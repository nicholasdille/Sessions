## Professionalize

<div><i class="fas fa-cogs fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Store code in repository:

```
root
 |
 \-- $ModuleName
 |    |
 |    \-- $ModuleName.psd1
 |    \-- $ModuleName.psm1
 |
 \-- Build.ps1
```

Focus on code maintenance

--

## Pipeline Steps

<div><i class="fas fa-forward fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

1. Update module manifest

1. Run `PSScriptAnalyzer`

1. Load module

1. Run automated tests

1. Publish to PSGallery or NuGet feed

--

## Development strategy

<div><i class="fas fa-code-branch fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

Meaning of `master`

Use of branches

Prevent commits to common branches

Use pull/merge requests

Resolve concurrent development using feature branches