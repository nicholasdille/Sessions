$OutputPath = Join-Path -Path $PSScriptRoot -ChildPath 'Output'
$Credential = Get-Credential
$ConfigData = @{
    AllNodes = @(
        @{
            NodeName = '*'
            PsDscAllowPlainTextPAssword = $true
        }

        @{
            NodeName = 'XDDC-02.demo.dille.name'
            Role     = 'DeliveryController'
        }

        @{
            NodeName = 'VDA-01.demo.dille.name'
            Role     = 'ServerVDA'
        }
    )
}

Configuration XenDesktopStandalone {
    
    # Must be able to access install media
    # Must be able to manage SQL server
    # CredSSP fails because of existing domain policy

    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
    )

    #region Required modules
    Import-DscResource –ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xCredSSP
    Import-DscResource -ModuleName cPfxCertificate
    Import-DscResource -ModuleName CitrixXenDesktop7
    Import-DscResource -ModuleName CitrixXenDesktop7Lab
    #endregion

    Node $AllNodes.WHERE{$_.Role -ieq 'DeliveryController'}.NodeName {

        XD7LabLicenseServer 'LicenseServer' {
            XenDesktopMediaPath = '\\srv2\Install\Citrix\XenApp 7.6\XenApp_and_XenDesktop7_6'
            Credential          = $Credential
        } # LicenseServer
    
        XD7LabSite 'Site' {
            DependsOn           = '[XD7LabLicenseServer]LicenseServer'
            XenDesktopMediaPath = '\\srv2\Install\Citrix\XenApp 7.6\XenApp_and_XenDesktop7_6'
            Credential          = $Credential
            SiteName            = 'PsDscXenDesktop7'
            DatabaseServer      = 'SQL-01.demo.dille.name\VMM'
            LicenseServer       = 'XDDC-02.demo.dille.name'
            SiteAdministrators  = $Credential.UserName
            DelegatedComputers  = ('XDDC-02.demo.dille.name', 'XDDC-02')
        } # Site

        XD7LabStorefront 'Storefront' {
            DependsOn           = '[XD7LabSite]Site'
            XenDesktopMediaPath = '\\srv2\Install\Citrix\XenApp 7.6\XenApp_and_XenDesktop7_6'
            ControllerAddress   = 'XDDC-02.demo.dille.name'
        } # Storefront

    } # Node

    Node $AllNodes.Where{$_.Role -ieq 'ServerVDA'}.NodeName {
        
        XD7LabSessionHost 'SessionHost' {
            XenDesktopMediaPath = '\\srv2\Install\Citrix\XenApp 7.6\XenApp_and_XenDesktop7_6'
            ControllerAddress   = 'XDDC-02.demo.dille.name'
            RDSLicenseServer    = 'XDDC-02.demo.dille.name'
        }

    } # Node

} #Configuration

XenDesktopStandalone -OutputPath $OutputPath -Credential $Credential -ConfigurationData $ConfigData