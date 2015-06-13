@{
    AllNodes    = @(
        @{
            NodeName                    = '*'
            PSDscAllowPlainTextPassword = $true
        }

        @{
            NodeName                    = '0f0042ea-fd8a-4701-8659-a6c363bfce90'
            Roles                       = @{
                Hypervisor              = @{
                    VhdxTemplatePath = '\\demo.dille.name\storage\VMM_Library\VHD'
                    StorageBasePath  = '\\demo.dille.name\storage\VMM_Storage'
                    Teams = @(
                        @{
                            Name                   = 'TeamDatacenter'
                            Adapters               = ('Ethernet0', 'Ethernet1 2')
                            TeamingMode            = 'SwitchIndependent'
                            LoadBalancingAlgorithm = 'HyperVPort'
                        }
                    )
                    VirtualSwitches = @(
                        @{
                            Name              = 'Datacenter'
                            Type              = 'External'
                            Adapter           = 'TeamDatacenter'
                        }
                        @{
                            Name              = 'SomeName'
                            Type              = 'Private'
                        }
                    )
                    VirtualAdapters        = @{
                        Management         = @{
                            InterfaceAlias = 'vEthernet (Management)'
                            SwitchName     = 'Datacenter'
                            VlanId         = 0
                            Weight         = 20
                            IPAddress      = '10.0.0.154'
                            SubnetMask     = 24
                            DefaultGateway = '10.0.0.1'
                            DnsServers     = ('10.0.0.2')
                        }
                        LiveMigration      = @{
                            InterfaceAlias = 'vEthernet (LiveMigration)'
                            SwitchName     = 'Datacenter'
                            VlanId         = 10
                            Weight         = 30
                            IPAddress      = '10.0.1.154'
                            SubnetMask     = 24
                        }
                    }
                }
            }
        }

        @{
            NodeName                    = '3b16f320-d761-4550-89ab-89c36620869a'
            Roles                       = @{
                FirstDomainController   = @{
                    DomainName          = 'contoso.com'
                }
                VirtualMachine          = $true
            }
        }

        @{
            NodeName                       = '8ea55143-4081-4a77-999b-7f89fa5e15dc'
            Roles                          = @{
                AdditionalDomainController = @{
                    DomainName             = 'contoso.com'
                }
                VirtualMachine          = $true
            }
        }
    )
    
    Domains = @(
        @{
            DomainName       = 'contoso.com'
            Credential       = $Credential
            RetryCound       = 3
            RetryIntervalSec = 60
        }
    )
}