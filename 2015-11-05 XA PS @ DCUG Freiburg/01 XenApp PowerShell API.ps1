Add-PSSnapin Citrix*

Get-Command -Module Citrix* | Measure-Object
Get-Command -Module Citrix* | Group-Object -Property ModuleName