Configuration DisableDscReboots {

    Node 'VDA-01.demo.dille.name' {

        LocalConfigurationManager {
            RebootNodeIfNeeded = $false
            ConfigurationMode  = 'ApplyOnly'
        }
    }
}

DisableDscReboots -OutputPath "$PSScriptRoot\Output"