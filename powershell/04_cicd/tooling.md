## Script Analyzer

<div><i class="fas fa-search fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Checks for well-known mistakes

Rules are a community effort [<i class="fas fa-external-link-alt"></i>](https://github.com/PowerShell/PSScriptAnalyzer)

```powershell
Invoke-ScriptAnalyzer -Path .\ConvertTo-Base64.ps1
```

Findings can be suppressed:

```powershell
function ConvertTo-Base64 {
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    "PSProvideCommentHelp",
    "",
    Justification="Just an example"
  )]
  #...
}
```

--

## Test Driven Design

<div><i class="fas fa-vial fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Unit tests in PowerShell with Pester [<i class="fas fa-external-link-alt"></i>](https://github.com/pester/Pester)

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

## Comment Based Help

<div><i class="fas fa-book fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Comment inside function body [<i class="fas fa-external-link-alt"></i>](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-6)

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

## Markdown Based Help

<div><i class="fas fa-book fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Write your help files in markdown with platyPS [<i class="fas fa-external-link-alt"></i>](https://github.com/PowerShell/platyPS)

Generate markdown help for existing functions:

```powershell
New-MarkdownHelp -Module MyAwesomeModule -OutputFolder .\docs
```

Generate PowerShell help files from markdown:

```powershell
New-ExternalHelp .\docs -OutputPath en-US\
```

Add another step to your pipeline