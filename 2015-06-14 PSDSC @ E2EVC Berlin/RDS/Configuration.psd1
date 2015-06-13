@{
    AllNodes = @(

        @{
            NodeName                    = '*'
            PSDscAllowPlainTextPassword = $true
        }

        @{
            NodeName                    = 'RDS-01.demo.dille.name'
            Role                        = ('All')
        }

        @{
            NodeName                    = 'RDS-02.demo.dille.name'
            Role                        = ('SessionHost')
        }

    )
}