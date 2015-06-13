Configuration ActiveDirectoryDomainServices {
    param()

    #region Import resources
    Import-DscResource -ModuleName xActiveDirectory
    #endregion
 
    Node $AllNodes.NodeName {

        #region Role Hypervisor
        if ($Node.Roles.Keys -icontains 'Hypervisor') {
            $RoleHypervisor = $Node.Roles.Hypervisor

            #region WindowsFeature
            WindowsFeature Hyper-V {
                Ensure    = 'Present'
                Name      = 'Hyper-V'
            }
            WindowsFeature Hyper-V-PowerShell {
                Ensure    = 'Present'
                Name      = 'Hyper-V-PowerShell'
            }
            #endregion
                    
            #region Teaming
            foreach ($Team in $RoleHypervisor.Teams) {
                cNetworkTeam "Team$($Team.Name)" {
                    Name                   = $Team.Name
                    TeamingMode            = $Team.TeamingMode
                    LoadBalancingAlgorithm = $Team.LoadBalancingAlgorithm
                    TeamMembers            = $Team.Adapters
                    Ensure                 = 'Present'
                }
            }
            #endregion
 
            #region Virtual Switch
            foreach ($Switch in $RoleHypervisor.VirtualSwitches) {
                if ($Switch.Type -ieq 'External') {
                    cVMSwitch "Switch$($Switch.Name)" {
                        Name                   = $Switch.Name
                        Type                   = $Switch.Type
                        AllowManagementOS      = $false
                        MinimumBandwidthMode   = 'Weight'
                        NetAdapterName         = $Switch.Adapter
                        Ensure                 = 'Present'
                        DependsOn              = ("[cNetworkTeam]Team$($Switch.Adapter)", '[WindowsFeature]Hyper-V', '[WindowsFeature]Hyper-V-PowerShell')
                    }

                } elseif ($Switch.Type -ieq 'Private') {
                    cVMSwitch "Switch$($Switch.Name)" {
                        Name                   = $Switch.Name
                        Type                   = $Switch.Type
                        Ensure                 = 'Present'
                        DependsOn              = ('[WindowsFeature]Hyper-V', '[WindowsFeature]Hyper-V-PowerShell')
                    }

                } elseif ($Switch.Type -ieq 'Internal') {
                    throw ('Hyper-V Virtual Switch of type {0} has not been implemented yet' -f $Switch.Type)
                }
            }
            #endregion
 
            #region DNS
            $ManagementAdapter = $Node.Roles.Hypervisor.VirtualAdapters.Management
            xDNSServerAddress DNS {
                InterfaceAlias         = $ManagementAdapter.InterfaceAlias
                AddressFamily          = 'IPV4'
                Address                = $ManagementAdapter.DnsServers
                DependsOn              = '[xIPAddress]AdapterAddressManagement'
            }
            #endregion

            #region Adapter
            foreach ($AdapterName in $RoleHypervisor.VirtualAdapters.Keys) {
                $Adapter = $RoleHypervisor.VirtualAdapters.$AdapterName

                cVMNetworkAdapter "Adapter$AdapterName" {
                    Name                   = $AdapterName
                    SwitchName             = $Adapter.SwitchName
                    ManagementOS           = $true
                    Ensure                 = 'Present'
                    DependsOn              = "[cVMSwitch]Switch$($Adapter.SwitchName)"
                }

                cVMNetworkAdapterSettings "AdapterSettings$AdapterName" {
                    Name                   = $AdapterName
                    SwitchName             = $Node.SwitchName
                    ManagementOS           = $true
                    MinimumBandwidthWeight = $Adapter.Weight
                    DependsOn              = ("[cVMSwitch]Switch$($Adapter.SwitchName)", "[cVMNetworkAdapter]Adapter$AdapterName")
                }
 
                if ($Adapter.VlanId -gt 0) {
                    cVMNetworkAdapterVlan "AdapterVlan$AdapterName" {
                        Name                   = $AdapterName
                        ManagementOS           = $true
                        AdapterMode            = 'Access'
                        VlanId                 = $Adapter.VlanId
                        DependsOn              = ("[cVMSwitch]Switch$($Adapter.SwitchName)", "[cVMNetworkAdapter]Adapter$AdapterName")
                    }
                }
 
                xIPAddress "AdapterAddress$AdapterName" {
                    InterfaceAlias         = $Adapter.InterfaceAlias
                    AddressFamily          = 'IPV4'
                    IPAddress              = $Adapter.IPAddress
                    SubnetMask             = $Adapter.SubnetMask
                    DependsOn              = "[cVMNetworkAdapter]Adapter$AdapterName"
                }
            }
            #endregion

            #region Virtual Machines
            foreach ($VmNode in $AllNodes.where{$_.Roles.VirtualMachine}) {
                #region Variables
                $RoleVirtualMachine = $Node.Roles.VirtualMachine
                $VmName = $VmNode.Roles.Computer.MachineName
                $VmSwitchName = $VmNode.Roles.VirtualMachine.SwitchName
                $VmBasePath = (Join-Path -Path $RoleHypervisor.StorageBasePath -ChildPath $VmName)
                $VhdxTemplateName = $VmNode.Roles.VirtualMachine.VhdxTemplateName
                #endregion

                #region VHDX Copy
                File ('VhdxCopy_' + $VmName) {
                    Ensure          = 'Present'
                    Type            = 'File'
                    SourcePath      = (Join-Path -Path $RoleHypervisor.VhdxTemplatePath -ChildPath $VhdxTemplateName)
                    DestinationPath = (Join-Path -Path $VmBasePath -ChildPath $VhdxTemplateName)
                    Force           = $True
                }
                #endregion

                #region Hyper-V VM
                $StartupMemory = 512MB
                if ($VmNode.Roles.VirtualMachine.StartupMemory) {
                    $StartupMemory = $VmNode.Roles.VirtualMachine.StartupMemory
                }
                $MinimumMemory = 512MB
                if ($VmNode.Roles.VirtualMachine.MinimumMemory) {
                    $MinimumMemory = $VmNode.Roles.VirtualMachine.MinimumMemory
                }
                $MaximumMemory = 2048MB
                if ($VmNode.Roles.VirtualMachine.MaximumMemory) {
                    $MaximumMemory = $VmNode.Roles.VirtualMachine.MaximumMemory
                }
                $ProcessorCount = 2
                if ($VmNode.Roles.VirtualMachine.ProcessorCount) {
                    $ProcessorCount = $VmNode.Roles.VirtualMachine.ProcessorCount
                }
                $State = 'Off'
                if ($VmNode.Roles.VirtualMachine.State) {
                    $State = $VmNode.Roles.VirtualMachine.State
                }
 
                xVMHyperV ('NewVm_' + $VmName) {
                    Ensure          = 'Present'
                    Generation      = 'vhdx'
                    StartupMemory   = $StartupMemory
                    MinimumMemory   = $MinimumMemory
                    MaximumMemory   = $MaximumMemory
                    MACAddress      = $VmNode.Roles.VirtualMachine.MACAddress
                    Path            = (Join-Path -Path $RoleHypervisor.StorageBasePath -ChildPath $VmName)
                    ProcessorCount  = $ProcessorCount
                    RestartIfNeeded = $True
                    State           = $State
                    SwitchName      = $VmSwitchName
                    Name            = $VmName
                    VHDPath         = (Join-Path -Path $VmBasePath -ChildPath $VhdxTemplateName)
                    DependsOn       = (('[File]VhdxCopy_' + $VmName), ('[xVMSwitch]' + $VmSwitchName))
                }
                #endregion
            }
            #endregion
        }
        #endregion

        #region Roles DomainController
        if ($Node.Roles.Keys -icontains 'FirstDomainController' -Or $Node.Roles.Keys -icontains 'AdditionalDomainController') {
            WindowsFeature AD-Domain-Services {
                Ensure    = 'Present'
                Name      = 'AD-Domain-Services'
            }
            
            WindowsFeature RSAT-AD-PowerShell {
                Ensure    = 'Present'
                Name      = 'RSAT-AD-PowerShell'
            }
            
            WindowsFeature RSAT-ADDS-Tools {
                Ensure    = 'Present'
                Name      = 'RSAT-ADDS-Tools'
            }
        }

        #region Role FirstDomainController
        if ($Node.Roles.Keys -icontains 'FirstDomainController') {
            $RoleFirstDc = $Node.Roles.FirstDomainController
            $RoleDomain  = $ConfigurationData.Domains | Where-Object {$_.DomainName -ieq $RoleFirstDc.DomainName}
            
            xADDomain 'FirstDc_$($RoleFirstDc.DomainName)' {
                DomainName                    = $RoleDomain.DomainName
                DomainAdministratorCredential = $RoleDomain.Credential
                SafemodeAdministratorPassword = $RoleDomain.Credential
                DependsOn                     = ('[WindowsFeature]AD-Domain-Services', '[WindowsFeature]RSAT-AD-PowerShell', '[WindowsFeature]RSAT-ADDS-Tools')
            }

            xWaitForADDomain 'ForestWait_$($RoleFirstDc.DomainName)' {
                DomainName           = $RoleDomain.DomainName
                DomainUserCredential = $RoleDomain.Credential
                RetryCount           = $RoleDomain.RetryCount
                RetryIntervalSec     = $RoleDomain.RetryIntervalSec
                DependsOn            = "[xADDomain]FirstDc_$($RoleFirstDc.DomainName)"
            }
        }
        #endregion

        #region Role AdditionalDomainController
        if ($Node.Roles.Keys -icontains 'AdditionalDomainController') {
            $RoleNextDc = $Node.Roles.AdditionalDomainController
            $RoleDomain  = $ConfigurationData.Domains | Where-Object {$_.DomainName -ieq $RoleFirstDc.DomainName}
            
            xWaitForADDomain "ForestWait_$($RoleNextDc.DomainName)" {
                DomainName           = $RoleDomain.DomainName
                DomainUserCredential = $RoleDomain.Credential
                RetryCount           = $RoleDomain.RetryCount
                RetryIntervalSec     = $RoleDomain.RetryIntervalSec
            }

            xADDomainController "NextDc$($RoleNextDc.DomainName)" {
                DomainName                    = $RoleDomain.DomainName
                DomainAdministratorCredential = $RoleDomain.Credential
                SafemodeAdministratorPassword = $RoleDomain.Credential
                DependsOn                     = ("[xWaitForADDomain]ForestWait_$($RoleNextDc.DomainName)", '[WindowsFeature]AD-Domain-Services', '[WindowsFeature]RSAT-AD-PowerShell', '[WindowsFeature]RSAT-ADDS-Tools')
            }
        }
        #endregion
        #endregion

    }#End Node
}#End Configuration