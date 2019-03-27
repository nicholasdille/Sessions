## Tips and Tricks

<div><i class="fas fa-magic fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Create coding guidelines

Prevent re-inventing the wheel - except your wheel besser ;-)

--

## Tips and Tricks

<div><i class="fas fa-magic fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Pre-install required modules for `Update-ModuleManifest` to work

Add build number to `ModuleVersion` in module manifest

`Update-ModuleManifest` mangles nicely formatted module manifest

Test against the module instead of the `*.ps1` files

--

## Ways to load a module

<div><i class="fas fa-magic fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Load from well-known location

```powershell
Import-Module
```

Load from arbitrary location

```powershell
Import-Module -Name .\MyModule\MyModule.psd1
```

Loading from location of source files

```powershell
$Env:PSModulePath = "~\MyModules;$Env:PSModulePath"
```

--

## Private module repository

<div><i class="fas fa-shopping-cart fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Some code must remain private

Use any NuGet feed to host modules

Supported in many [commercial products](https://docs.microsoft.com/en-us/nuget/hosting-packages/overview)

Create your own feed using `NuGet.Server` from .NET Foundation

--

## Prerelease versions

Module manifest can contain a prerelease tag [<i class="fas fa-external-link-alt"></i>](https://devblogs.microsoft.com/powershell/prerelease-versioning-added-to-powershellget-and-powershell-gallery/):

```powershell
@{
  ModuleVersion = '2.0.0'
  #...
  PrivateData = @{
    PSData = @{
      Prerelease = '-alpha'
    }
  }
}
```

This can be used when working with modules:

```powershell
Find-Module -Name GoCD -AllowPrerelease
Install-Module -Name GoCD -AllowPrerelease
```

--

## Prerelease versions

`ModuleVersion` usually follows [SemVer](https://semver.org/)

`ModuleVersion` may be MAJOR.MINOR.PATCH.BUILD

`RequiredModules` must follow SemVer like MAJOR.MINOR.PATCH

`RequiredModules` does not allow prerelease tag

**Try to avoid prerelease tags**