$WorkPath = "$Env:Temp\TecCon"
$PortMap = @{
    '01'   = '10001'
    '02'   = '10002'
    '03'   = '10003'
    '04'   = '10004'
    '05'   = '10005'
    '06'   = '10006'
    '07'   = '10007'
    '08'   = '10008'
    '09'   = '10009'
    '10'   = '10010'
}

if (Test-Path -Path "$WorkPath" -ErrorAction SilentlyContinue) {
    if ($(Get-ChildItem -Path "$WorkPath" -File | Measure-Object -Line).Lines -gt 0) {
        Write-Error ('Unable to use working directory "{0}"' -f $WorkPath)
        Start-Sleep -Seconds 10
    }
}

Write-Host 'Creating working directory...'
New-Item -Path "$WorkPath" -ItemType Directory -ErrorAction Stop -Force | Out-Null
Write-Host 'Copying certificates...'
Copy-Item -Path "$PSScriptRoot\*.pem" -Destination "$WorkPath" -Force

if (Test-Path -Path "$PSScriptRoot\..\docker.exe" -ErrorAction SilentlyContinue) {
    Write-Host 'Copying docker.exe...'
    Copy-Item -Path "$PSScriptRoot\..\docker.exe" -Destination "$WorkPath\docker.exe" -Force
}
if (-Not (Test-Path "$WorkPath\docker.exe" -ErrorAction SilentlyContinue)) {
    Write-Host 'Downloading docker.exe...'
    Invoke-WebRequest -UseBasicParsing -Uri 'https://master.dockerproject.org/windows/amd64/docker.exe' -OutFile "$WorkPath\docker.exe" -ErrorAction Stop
}

$DockerPort = '2376'
$LabIndex = Split-Path -Path "$PSScriptRoot" -Leaf
if ($PortMap.ContainsKey($LabIndex)) {
    $DockerPort = $PortMap[$LabIndex]
}
Set-Content -Path "$WorkPath\DockerPort.txt" -Value $DockerPort

Write-Host "Creating start script using Docker port $DockerPort..."
@'
Set-Location -Path "$PSScriptRoot"
powershell -NoExit -Command {
    $PSScriptRoot = Get-Location
    $DockerPort = Get-Content -Path "$PSScriptRoot\DockerPort.txt"
    $Env:Path = "$Env:Path;$PSScriptRoot"
    $Env:DOCKER_HOST = "tcp://srv1.inmylab.de:$DockerPort"
    $Env:DOCKER_TLS_VERIFY = 1
    $Env:DOCKER_CERT_PATH = "$PSScriptRoot"
    Write-Output ('DOCKER_HOST={0} // DOCKER_TLS_VERIFY={1} // DOCKER_CERT_PATH={2}' -f $Env:DOCKER_HOST, $Env:DOCKER_TLS_VERIFY, $Env:DOCKER_CERT_PATH)
    Write-Output ''
    docker version
    Write-Output ''
}
'@ | Set-Content -Path "$WorkPath\Start-DockerClient.ps1" -Force

Write-Host 'Done. Sleeping for 10s...'
Start-Sleep -Seconds 10