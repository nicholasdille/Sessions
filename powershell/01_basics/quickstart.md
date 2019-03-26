## Way of the ~~Warrior~~ Scripter

<div><i class="fas fa-battery-full fa-10x"></i></div> <!-- .element: style="position: absolute; z-index: -1; width: 100%; text-align: center; -webkit-filter: opacity(.5); filter: opacity(.25);" -->

1. Create *scripts* to automate common tasks

1. Add *parameters* to scripts

1. Reuse code with *functions*

1. Share code using *modules*

Slowly but surely you are becoming a

PowerShell professional <!-- .element: style="text-align: center;" -->

--

## Assumption 1

You know pipelines and filtering:

```powershell
Get-ChildItem -Path C:\Windows\System32 -File |
    Where-Object { $_.Extension } |
    Select-Object -Property Extension,Size |
    Group-Object -Property Extension -NoElement |
    Sort-Object -Property Count -Descending
```

An array or objects is similar to a database table

- `Where-Object` filters objects (rows)
- `Select-Object` filters properties (fields)

Remember: Everything is an object

--

## Assumption 2

You know how to help yourself:

```powershell
Get-ChildItem -?
Get-Help Get-ChildItem -Full
Get-Command *-Item
'some_string' | Get-Member
```

Jeffrey Snover's favourite cmdlet is `Get-Help`

Run `Update-Help` once in a while

--

## Assumption 3

You know how to write functions:

```powershell
function ConvertTo-Base64 {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Data
  )

  [Convert]::ToBase64String(
    [System.Text.Encoding]::UTF8.GetBytes($Item)
  )
}
```

Naming scheme is `Verb-Noun` (singular)

`Get-Verb` displays approved verbs
