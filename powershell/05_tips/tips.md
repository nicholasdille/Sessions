## Tips and Tricks

<div><i class="fas fa-vial fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

XXX pester

--

## Tips and Tricks

<div><i class="fas fa-book fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

XXX platyps

--

## Tips and Tricks

<div><i class="fas fa-magic fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Pre-install required modules for `Update-ModuleManifest` to work

Add build number to module manifest

`Update-ModuleManifest` mangles nicely formatted module manifest

Do not test against `*.ps1` files

--

## Ways to load a module

<div><i class="fas fa-magic fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

1. Load from well-known location

```powershell
Import-Module
```

1. Load from arbitrary location

```powershell
Import-Module -Name .\MyModule\MyModule.psd1
```

1. Prefer loading from source

```powershell
$Env:PSModulePath = "~\MyModules;$Env:PSModulePath"
```

--

## Private module repository

<div><i class="fas fa-shopping-cart fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

XXX custom nuget feed