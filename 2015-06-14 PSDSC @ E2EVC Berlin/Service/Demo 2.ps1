$ConfigurationFile = Join-Path -Path $PSScriptRoot -ChildPath 'Demo 2 - Configuration.psm1'
$ConfigDataFile    = Join-Path -Path $PSScriptRoot -ChildPath 'Demo 2 - ConfigData.psd1'
$OutputPath        = Join-Path -Path $PSScriptRoot -ChildPath 'Output'
$ContosoCredential = Get-Credential

$ConfigData = Invoke-Expression -Command (Get-Content -Raw -Path $ConfigDataFile)

Import-Module $ConfigurationFile -Force

ActiveDirectoryDomainServices -OutputPath $OutputPath -ConfigurationData $ConfigData