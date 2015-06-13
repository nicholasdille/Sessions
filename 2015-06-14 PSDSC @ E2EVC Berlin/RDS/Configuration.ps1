$ConfigurationFile = Join-Path -Path $PSScriptRoot -ChildPath 'Configuration.psm1'
$ConfigDataFile    = Join-Path -Path $PSScriptRoot -ChildPath 'Configuration.psd1'
$OutputPath        = Join-Path -Path $PSScriptRoot -ChildPath 'Output'
$Credential        = Get-Credential

Import-Module $ConfigurationFile -Force

$ConfigData = Invoke-Expression -Command (Get-Content -Raw -Path $ConfigDataFile)
RdsQuickSessionDeployment -Credential $Credential -ConfigurationData $ConfigData -OutputPath $OutputPath
RdsRoleSessionHost        -Credential $Credential -ConfigurationData $ConfigData -OutputPath $OutputPath