# List loaded modules
Get-Module

# Installed modules
Get-Module -ListAvailable

# Explore modules
Get-Command -Module NetAdapter Get-*
# Module NetAdapter is implicitly loaded
Get-Module
Get-Module -Name NetAdapter | Format-List *

# Browse modules on PowerShell Gallery
& 'https://powershellgallery.com'
# Search modules from console
Find-Module -Name powershell-yaml

# Install module
Install-Module -Name powershell-yaml -Scope CurrentUser