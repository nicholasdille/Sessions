#region Hilfe zur Selbsthilfe

# Paradigma: Get-Verb
Get-Verb
Get-Verb | group Group

# Viele, viele Cmdlets
Get-Command | measure

# Get-Command mit Wildcards
Get-Command Get-*
Get-Command *-Item

# RTFM
Get-Help Get-Process
Get-Help Get-Process -Examples
Get-Help about_*

# Untersuchen von Cmdlets
Get-ChildItem | Get-Member

# Finden von Modulen
Get-Module -ListAvailable

# Befehle bauen
Show-Command

#endregion Hilfe zur Selbsthilfe

#region Navigation

# Verzeichnisinhalt
Get-ChildItem

# Datei oder Ordner
Get-Item -Path C:\Windows\System32

# Verzeichniswechsel
Push-Location
Set-Location -Path C:\Windows\System32

# Aktuelles Verzeichnis
Get-Location
Pop-Location

# PSDrives
Get-PSDrive | select Name,Provider,Root

# Item-Befehle zur Verwaltung von Laufwerken
Get-Command *-Item,*-ItemProperty,*-ChildItem

# Was ist Invoke-Item?
Get-Help Invoke-Item

#endregion Navigation

#region Filtern und Darstellen

# Filtern mit where
gci C:\Windows | where Extension -ieq '.dll'
# ? statt where
gci C:\Windows | ? Extension -ieq '.dll'

# Dateisystemobjekte haben viele Eigenschaften und Methoden
gci C:\Windows | ? Extension -ieq '.dll' | gm
# Filtern mit select
gci C:\Windows | ? Extension -ieq '.dll' | select Name,FullName

# Gruppieren und Sortieren
gci C:\Windows | ? Extension -In ('.ini','.exe','.dll') | select Name,Extension | group Extension | sort Count -Desc

# Komplexere Filter als Skriptblock
gci C:\Windows | ? {-Not $_.PSIsContainer}

# Schleifen (foreach oder %)
gci C:\Windows | ? PSIsContainer | % {Copy-Item -Path $_.FullName -Destination C:\Windows\Temp -Recurse -WhatIf}

#endregion Filtern und Darstellen