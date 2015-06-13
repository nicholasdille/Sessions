Configuration RdsQuickSessionDeployment {
    param(
        [pscredential]
        $Credential
    )

    #region Import resources
    Import-DscResource -ModuleName cRemoteDesktopServices
    #endregion

    Node $AllNodes.Where{$_.Role -icontains 'All'}.NodeName {

        WindowsFeature FeatureRDCB {
            Name   = 'RDS-Connection-Broker'
            Ensure = 'Present'
        }

        WindowsFeature FeatureRDSH {
            Name   = 'RDS-RD-Server'
            Ensure = 'Present'
        }

        WindowsFeature FeatureRDWA {
            Name   = 'RDS-Web-Access'
            Ensure = 'Present'
        }

        cRDSessionDeployment Deployment {
            Ensure               = 'Present'
            ConnectionBroker     = $Node.NodeName
            WebAccess            = $Node.NodeName
            SessionHost          = $Node.NodeName
            Credential           = $Credential
            DependsOn            = '[WindowsFeature]FeatureRDCB', '[WindowsFeature]FeatureRDSH', '[WindowsFeature]FeatureRDWA'
        }
    }
}

Configuration RdsRoleSessionHost {
    param(
        [pscredential]
        $Credential
    )

    #region Import resources
    Import-DscResource -ModuleName cRemoteDesktopServices
    #endregion

    Node $AllNodes.Where{$_.Role -icontains 'SessionHost'}.NodeName {

        WindowsFeature RDS-RD-Server {
            Name   = 'RDS-RD-Server'
            Ensure = 'Present'
        }

        cRDSessionHost Deployment {
            Ensure               = 'Present'
            ConnectionBroker     = $AllNodes.Where{$_.Role -icontains 'All'}.NodeName
            Credential           = $Credential
            DependsOn            = '[WindowsFeature]RDS-RD-Server'
        }
    }
}