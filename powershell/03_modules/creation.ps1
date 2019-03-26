# Consider the following function
# file ConvertTo-Base64.ps1
. "\ConvertTo-Base64.ps1"
ConvertTo-Base64 'blarg', 'blubb'
'fubar', 'snafu' | ConvertTo-Base64

# Create a new module
New-Item -Path ".\Base64" -ItemType Directory -Force
$Params = @{
    Path              = '.\Base64\Base64.psd1'
    Guid              = New-Guid
    Author            = 'Nicholas Dille'
    Description       = 'Base64'
    PowerShellVersion = $PSVersionTable.PSVersion
}
New-ModuleManifest @Params

# Test module
Import-Module ".\Base64\Base64.psd1" -Force
Get-Module
Get-Module -Name Base64 | Format-List *

# Add function to module
New-Item -Path ".\Base64\Functions" -ItemType Directory -Force
Copy-Item -Path ConvertTo-Base64.ps1 -Destination ".\Base64\Functions"
# Add root module to load
Copy-Item -Path Base64.psm1 -Destination ".\Base64"
Update-ModuleManifest -Path ".\Base64\Base64.psd1" -RootModule 'Base64.psm1'
# Add function to exports
Update-ModuleManifest -Path ".\Base64\Base64.psd1" -FunctionsToExport 'ConvertTo-Base64'

# Test module
Import-Module ".\Base64\Base64.psd1" -Force
Get-Module -Name Base64
Base64\ConvertTo-Base64 'blarg', 'blubb'