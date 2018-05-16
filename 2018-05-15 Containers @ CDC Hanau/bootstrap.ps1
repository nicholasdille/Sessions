$TargetPath = "$PSScriptRoot\lib"

$RevealJsVersion = '3.6.0'
$FontAwesomeVersion = '5.0.13'

[System.Net.ServicePointManager]::SecurityProtocol = 'Tls11,Tls12'

if (Test-Path -Path "$TargetPath\reveal.js@$RevealJsVersion") {
    Write-Host "reveal.js version $RevealJsVersion already exists"

} else {
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/hakimel/reveal.js/archive/$RevealJsVersion.zip" -OutFile "revealjs-$RevealJsVersion.zip"
    Expand-Archive -Path "revealjs-$RevealJsVersion.zip" -DestinationPath "$TargetPath"
    Rename-Item -Path "$TargetPath\reveal.js-$RevealJsVersion" -NewName "$TargetPath\reveal.js@$RevealJsVersion"
}

if (Test-Path -Path "$TargetPath\fontawesome-free@$FontAwesomeVersion") {
    Write-Host "FontAwesome versiion $FontAwesomeVersion already exists"

} else {
    New-Item -Path "$TargetPath\fontawesome-free@$FontAwesomeVersion\css" -ItemType Directory -Force | Out-Null
    New-Item -Path "$TargetPath\fontawesome-free@$FontAwesomeVersion\webfonts" -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/$FontAwesomeVersion/web-fonts-with-css/css/fontawesome-all.min.css" -OutFile "$TargetPath\fontawesome-free@$FontAwesomeVersion\css\fontawesome-all.min.css"
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/$FontAwesomeVersion/web-fonts-with-css/webfonts/fa-brands-400.woff2" -OutFile "$TargetPath\fontawesome-free@$FontAwesomeVersion\webfonts\fa-brands-400.woff2"
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/$FontAwesomeVersion/web-fonts-with-css/webfonts/fa-regular-400.woff2" -OutFile "$TargetPath\fontawesome-free@$FontAwesomeVersion\webfonts\fa-regular-400.woff2"
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/$FontAwesomeVersion/web-fonts-with-css/webfonts/fa-solid-900.woff2" -OutFile "$TargetPath\fontawesome-free@$FontAwesomeVersion\webfonts\fa-solid-900.woff2"
}