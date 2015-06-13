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
            
            xADDomain 'FirstDc_$($RoleFirstDc.DomainName)' {
                DomainName                    = $RoleFirstDc.DomainName
                DomainAdministratorCredential = $RoleFirstDc.Credential
                SafemodeAdministratorPassword = $RoleFirstDc.Credential
                DependsOn                     = ('[WindowsFeature]AD-Domain-Services', '[WindowsFeature]RSAT-AD-PowerShell', '[WindowsFeature]RSAT-ADDS-Tools')
            }

            xWaitForADDomain 'ForestWait_$($RoleFirstDc.DomainName)' {
                DomainName           = $RoleFirstDc.DomainName
                DomainUserCredential = $RoleFirstDc.Credential
                RetryCount           = $RoleFirstDc.RetryCount
                RetryIntervalSec     = $RoleFirstDc.RetryIntervalSec
                DependsOn            = '[xADDomain]FirstDc_$($RoleFirstDc.DomainName)'
            }
        }
        #endregion

        #region Role AdditionalDomainController
        if ($Node.Roles.Keys -icontains 'AdditionalDomainController') {
            $RoleNextDc = $Node.Roles.AdditionalDomainController
            
            xWaitForADDomain 'ForestWait_$($RoleNextDc.DomainName)' {
                DomainName           = $RoleNextDc.DomainName
                DomainUserCredential = $RoleNextDc.Credential
                RetryCount           = $RoleNextDc.RetryCount
                RetryIntervalSec     = $RoleNextDc.RetryIntervalSec
            }

            xADDomainController 'NextDc$($RoleNextDc.DomainName)' {
                DomainName                    = $RoleNextDc.DomainName
                DomainAdministratorCredential = $RoleNextDc.Credential
                SafemodeAdministratorPassword = $RoleNextDc.Credential
                DependsOn                     = ('[xWaitForADDomain]ForestWait_$($RoleNextDc.DomainName)', '[WindowsFeature]AD-Domain-Services', '[WindowsFeature]RSAT-AD-PowerShell', '[WindowsFeature]RSAT-ADDS-Tools')
            }
        }
        #endregion

    }#End Node
}#End Configuration