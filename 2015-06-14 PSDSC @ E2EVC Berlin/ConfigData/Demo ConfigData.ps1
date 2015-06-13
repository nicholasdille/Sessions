$ConfigData = @{
    AllNodes    = @(
        @{
            NodeName                    = '3b16f320-d761-4550-89ab-89c36620869a'
            Roles                       = @{
                FirstDomainController   = @{
                    DomainName          = 'contoso.com'
                    RetryCount          = 3
                    RetryIntervalSec    = 10
                    Credential          = (Get-Credential)
                }
            }
            PSDscAllowPlainTextPassword = $true
        }
    )
}

Configuration ActiveDirectoryDomainServices {
    param()

    #region Import resources
    Import-DscResource -ModuleName xActiveDirectory
    #endregion
 
    Node $AllNodes.NodeName {

        #region Roles and features
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
        #endregion

        #region Role FirstDomainController
        if ($Node.Roles.Keys -icontains 'FirstDomainController') {
            $RoleFirstDc = $Node.Roles.FirstDomainController
            
            xADDomain "FirstDc_$($RoleFirstDc.DomainName)" {
                DomainName                    = $RoleFirstDc.DomainName
                DomainAdministratorCredential = $RoleFirstDc.Credential
                SafemodeAdministratorPassword = $RoleFirstDc.Credential
                DependsOn                     = ('[WindowsFeature]AD-Domain-Services', '[WindowsFeature]RSAT-AD-PowerShell', '[WindowsFeature]RSAT-ADDS-Tools')
            }

            xWaitForADDomain "ForestWait_$($RoleFirstDc.DomainName)" {
                DomainName           = $RoleFirstDc.DomainName
                DomainUserCredential = $RoleFirstDc.Credential
                RetryCount           = $RoleFirstDc.RetryCount
                RetryIntervalSec     = $RoleFirstDc.RetryIntervalSec
                DependsOn            = "[xADDomain]FirstDc_$($RoleFirstDc.DomainName)"
            }
        }
        #endregion

    }#End Node
}#End Configuration

$OutputPath = Join-Path -Path $PSScriptRoot -ChildPath 'Output'
ActiveDirectoryDomainServices -ConfigurationData $ConfigData -OutputPath $OutputPath