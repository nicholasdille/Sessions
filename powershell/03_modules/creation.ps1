# Consider the following function
# file ConvertTo-Base64.ps1

# Create a new module
New-Item -Path "$Env:TEMP\Base64" -ItemType Directory
Set-Location -Path "$Env:TEMP\Base64"
$Params = @{
    Path              = '.\Base64.psd1'
    Guid              = New-Guid
    RootModule        = '.\Base64.psm1'
    Author            = 'Nicholas Dille'
    Description       = 'Base64'
    PowerShellVersion = $PSVersionTable.PSVersion
}
New-ModuleManifest @Params
# Edit module manifest
code --add .

# Test module

# Add function to module
Copy-Item -Path "$PSScriptRoot\ConvertTo-Base64.ps1" -Destination .
# Add function to exports

# Test module