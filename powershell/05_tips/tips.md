## Tips and Tricks

<div><i class="fas fa-vial fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Test driven design (TDD) using pester [<i class="fas fa-external-link-alt"></i>](https://github.com/pester/Pester)

Unit tests in PowerShell

```powershell
Import-Module Base64
Describe 'ConvertTo-Base64` {
  It 'Accepts parameter' {
    { ConvertFrom 'BlargBlubb' } | Should Not Throw
  }
}
```

Place in separate files (`*.Tests.ps1`)

Place in separate filder (`\Tests`)

Also supports code coverage

--

## Tips and Tricks

<div><i class="fas fa-book fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Comment-based help [<i class="fas fa-external-link-alt"></i>](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-6)

```powershell
function ConvertTo-Base64 {
  <#
  .SYNOPSIS
  Converts strings to Base64
  .PARAMETER InputObject
  One or more strings
  .PARAMETER Encoding
  Encoding to use for conversion (default: UTF8)
  #>

  #...
}
```

Automatically available through `-?` and `Get-Help`

Also works for scripts

--

## Tips and Tricks

<div><i class="fas fa-book fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Write your help files in markdown with platyPS [<i class="fas fa-external-link-alt"></i>](https://github.com/PowerShell/platyPS):

Generate markdown help for existing functions:

```powershell
New-MarkdownHelp -Module MyAwesomeModule -OutputFolder .\docs
```

Generate PowerShell help files from markdown:

```powershell
New-ExternalHelp .\docs -OutputPath en-US\
```

Add another step to your pipeline

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