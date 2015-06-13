Configuration FirstDomainController {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $NodeName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $DomainName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]
        $RetryCount = 10
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]
        $RetryIntervalSec = 60
    )

    #region Import resources
    Import-DscResource -ModuleName xActiveDirectory
    #endregion
 
    Node $NodeName {

        #region Roles and features
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
        #endregion

        #region Role FirstDomainController
        xADDomain "FirstDc_$DomainName" {
            DomainName                    = $DomainName
            DomainAdministratorCredential = $Credential
            SafemodeAdministratorPassword = $Credential
            DependsOn                     = ('[WindowsFeature]AD-Domain-Services', '[WindowsFeature]RSAT-AD-PowerShell', '[WindowsFeature]RSAT-ADDS-Tools')
        }

        xWaitForADDomain "ForestWait_$DomainName" {
            DomainName           = $DomainName
            DomainUserCredential = $Credential
            RetryCount           = $RetryCount
            RetryIntervalSec     = $RetryIntervalSec
            DependsOn            = "[xADDomain]FirstDc_$DomainName"
        }
        #endregion

    }#End Node
}#End Configuration

$Guid = [System.Guid]::NewGuid()
FirstDomainController -NodeName $Guid -DomainName 'contoso.com' -Credential (Get-Credential)