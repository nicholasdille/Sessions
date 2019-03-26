## Proven structure 1/2

Recommended by multiple PowerShell enthusiasts

```
$ModuleName/
    |
    \-- $ModuleName.psd1
    |
    \-- $ModuleName.psm1
    |
    \-- Functions/
        |
        \-- *.ps1
```

One `.ps1` file per function

Sourced from root module

--

## Proven structure 2/2

...or even:

```powershell
$ModuleName/
    |
    \-- $ModuleName.psd1
    |
    \-- $ModuleName.psm1
    |
    \-- Functions/
        |
        \-- private/*.ps1
        \-- public/*.ps1
```

Separate exported functionality and internal functions

--

## Root Module

Root module usually contains code to source only:

```powershell
$Params = @{
    Path    = "$PSScriptRoot\Functions"
    Filter  = '*.ps1'
    Recurse = $true
}
Get-ChildItem @Params | ForEach-Object {
    . "$($_.FullName)"
}
```

Only put few other things in root module:

`Export-Member`, module variables, custom formats