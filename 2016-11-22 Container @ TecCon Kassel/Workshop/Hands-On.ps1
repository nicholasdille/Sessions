#region Prepare
Set-Location -Path c:\
git clone https://github.com/nicholasdille/Sessions.git
Set-Location -Path '.\Sessions\2016-11-22 Container @ TecCon Kassel'
#endregion

#region Build container host (stable release)
Add-WindowsFeature -Name Containers -Restart
Install-PackageProvider -Name NuGet -Force
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider

#endregion

#region Build container host (bleeding edge)
Invoke-WebRequest "https://master.dockerproject.org/windows/amd64/docker-1.13.0-dev.zip" -OutFile "$env:TEMP\docker-1.13.0-dev.zip" -UseBasicParsing
Expand-Archive -Path "$env:TEMP\docker-1.13.0-dev.zip" -DestinationPath $env:ProgramFiles
$env:path += ";c:\program files\docker"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
dockerd --register-service
'{"hosts": ["npipe://", "tcp://0.0.0.0:2375"]}' | Set-Content -Path 'C:\ProgramData\docker\config\daemon.json' -Force
Start-Service Docker
#endregion

#region Remoting Docker
docker -H 'tcp://10.0.0.200:2375' info
$Env:DOCKER_HOST='tcp://10.0.0.200:2375'
docker version
docker pull microsoft/windowsservercore:10.0.14393.321
docker pull microsoft/nanoserver:10.0.14393.321
#endregion

#region Remoting editing
Set-Item WSMan:\localhost\Client\TrustedHosts -Value *
Enter-PSSession -ComputerName 10.0.0.1 -Credential (Get-Credential -Message 'Enter password' -UserName 'Administrator')
PSEdit C:\Windows\System32\drivers\etc\hosts
#endregion

#region Build
ise iis\Dockerfile
docker build --name nicholasdille/iis iis 
#endregion

#region Run
docker run -d --rm --name iis nicholasdille/iis
& "$env:ProgramFiles\Internet Explorer\iexplore.exe" "http://$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' iis)"
docker stop iis
docker run -d -v c:\www:C:\Site --rm --name iis nicholasdille/iis
& "$env:ProgramFiles\Internet Explorer\iexplore.exe" "http://$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' iis)"
docker stop iis
#endregion

#region Push
docker push nicholasdille/iis
#endregion

#region Compose
Invoke-WebRequest -Uri 'https://github.com/docker/compose/releases/download/1.8.1/docker-compose-Windows-x86_64.exe' -OutFile "$Env:ProgramFiles\docker\docker-compose.exe" -UseBasicParsing
# TODO
docker run -p 1433:1433 --env sa_password=<YOUR SA PASSWORD> microsoft/mssql-server-2014-express-windows
#endregion