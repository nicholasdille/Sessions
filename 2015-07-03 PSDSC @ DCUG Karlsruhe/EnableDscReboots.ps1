Configuration EnableDscReboots {

    Node 'VDA-01.demo.dille.name' {

        LocalConfigurationManager {
            RebootNodeIfNeeded = $true
            ConfigurationMode  = 'ApplyAndAutoCorrect'
        }
    }
}

EnableDscReboots -OutputPath "$PSScriptRoot\Output"