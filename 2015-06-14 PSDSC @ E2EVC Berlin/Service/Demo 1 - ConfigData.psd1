@{
    AllNodes    = @(
        @{
            NodeName                    = '3b16f320-d761-4550-89ab-89c36620869a'
            PSDscAllowPlainTextPassword = $true
            Roles                       = @{
                FirstDomainController   = @{
                    DomainName          = 'contoso.com'
                    RetryCount          = 3
                    RetryIntervalSec    = 10
                    Credential          = $ContosoCredential
                }
            }
        }

        @{
            NodeName                       = '8ea55143-4081-4a77-999b-7f89fa5e15dc'
            PSDscAllowPlainTextPassword    = $true
            Roles                          = @{
                AdditionalDomainController = @{
                    DomainName             = 'contoso.com'
                    RetryCount             = 3
                    RetryIntervalSec       = 10
                    Credential             = $ContosoCredential
                }
            }
        }
    )
}