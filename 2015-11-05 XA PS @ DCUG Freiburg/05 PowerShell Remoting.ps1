function Import-RemoteModule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ComputerName
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
        ,
        [Parameter(Mandatory, ParameterSetName='Module')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ModuleName
        ,
        [Parameter(Mandatory, ParameterSetName='Snapin')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $SnapinName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $NewModuleName
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $NewModulePath = "$env:ProgramFiles\WindowsPowerShell\Modules"
    )

    Process {
        $Params = @{}
        if ($Credential) {
            Write-Verbose ('[{0}] Using credentials for {1}' -f $MyInvocation.MyCommand, $Credential.UserName)
            $Params = @{
                Credential = $Credential
            }
        }
        try {
            Write-Verbose ('[{0}] Creating session to {1}' -f $MyInvocation.MyCommand, $ComputerName)
            $session = New-PSSession -ComputerName $ComputerName @Params

        } catch {
            throw ('[{0}] Failed to establish session with {1}.' -f $MyInvocation.MyCommand, $ComputerName)
        }

        if ($PSCmdlet.ParameterSetName -ieq 'Module') {
            Write-Verbose ('[{0}] Importing module called {1}' -f $MyInvocation.MyCommand, $ModuleName)
            Invoke-Command -Session $session {Import-Module $Using:ModuleName}
            $ModuleNameToImport = $ModuleName

        } elseif ($PSCmdlet.ParameterSetName -ieq 'Snapin') {
            Write-Verbose ('[{0}] Adding snapin called {1}' -f $MyInvocation.MyCommand, $SnapinName)
            Invoke-Command -Session $session {Add-PSSnapin $Using:SnapinName}
            $ModuleNameToImport = $SnapinName
        }

        if ($NewModuleName) {
            Write-Verbose ('[{0}] Exporting session to permanent module called {1}' -f $MyInvocation.MyCommand, $NewModuleName)
            Export-PSSession -Session $session -Module $ModuleNameToImport -OutputModule "$NewModulePath\$NewModuleName" -FormatTypeName * -AllowClobber

        } else {
            Write-Verbose ('[{0}] Importing session' -f $MyInvocation.MyCommand)
            Import-PSSession -Session $session -Module $ModuleNameToImport
        }
    }
}

Import-RemoteModule -ComputerName xddc-01.demo.dille.name -SnapinName 'Citrix*' -NewModuleName CitrixXenApp7Sdk -NewModulePath "$env:USERPROFILE\Documents\WindowsPowerShell\Modules" -Verbose