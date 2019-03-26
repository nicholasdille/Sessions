## Modules

Code packaging and distribution

Installed in machine or user context

```powershell
Get-Module
Get-Module -ListAvailable
Import-Module -Name ThreadJob
Remove-Module -Name ThreadJob
Find-Module -Name PoshRSJob
Install-Module -Name PoshRSJob -Scope CurrentUser
```

Many modules are still being migrated to PS Core

New code must (at least) be tested on PS Core

--

## What is a module?

Nothing more than a directory

Modules are located in

```powershell
# PowerShell Core
~\Documents\PowerShell\Modules\
$Env:ProgramFiles\PowerShell\Modules\

# Windows PowerShell
~\Documents\WindowsPowerShell\Modules\
$Env:ProgramFiles\WindowsPowerShell\Modules\
```

Always prefer user scope

--

## Mandatory files

The *manifest* describes the module (`.psd1`)

The *root module* contains the code (`.psm1`)

```
$ModuleName/
    |
    +-- $ModuleName.psd1
    |
    +-- $ModuleName.psm1
```

The root module is referenced in the manifest

New manifests are generated using `New-ModuleManifest`

--

## Module manifest

Minimal manifest:

```
@{
    RootModule = 'MyModule.psm1'
    ModuleVersion = '0.0.1'
    GUID = 'cd0e76ae-1097-47b3-b80b-31c8e0493c13'
    Author = 'Nicholas Dille'
    Copyright = '(c) Nicholas Dille. All rights reserved.'
    Description = 'My helper library'
    FunctionsToExport = @()
}
```

Generate a new globally unique ID using `New-Guid`

--

## Dependencies

<div><i class="fas fa-link fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Installation dependencies:

```powershell
Install-Module -Name GoCd -Scope CurrentUser
$GoCdModule = Get-Module -Name GoCd -ListAvailable
$GoCdModule.RequiredModules
```

Add `RequiredModules` to module manifest

Dependencies are resolved at install time