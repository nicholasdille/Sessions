#region Docker EE Installation
# Requires Windows Server
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer
#endregion

#region Docker CE Installation
Invoke-WebRequest -Uri https://download.docker.com/win/static/stable/x86_64/docker-17.09.0-ce.zip -OutFile docker-17.09.0-ce.zip
Expand-Archive -Path docker-17.09.0-ce.zip -DestinationPath 'C:\Program Files\docker'
& 'C:\Program Files\docker\dockerd.exe' --register-service
Start-Service -Name Docker
New-Alias -Name docker -Value 'C:\Program Files\docker\docker.exe'
#endregion

#region Custom formatting
@"
{
    "psFormat": "table {{.ID}}\\t{{.Names}}\\t{{.Image}}\\t{{.Status}}",
    "imagesFormat": "table {{.ID}}\\t{{.Repository}}\\t{{.Tag}}\\t{{.Size}}",
    "servicesFormat": "table {{.ID}}\\t{{.Name}}\\t{{.Image}}\\t{{.Mode}}\\t{{.Replicas}}"
}
"@ | Set-Content -Path ~\.docker\config.json
#endregion

#region Windows Containers
docker pull microsoft/iis:windowsservercore-1709
docker run -d --name iis microsoft/iis:windowsservercore-1709
docker exec -it iis powershell
Get-Process
Get-Process -Name powershell
# Docker-in-Docker requires Windows Server 1709 and Docker CE 17.09
docker run -v //./pipe/docker_engine://./pipe/docker_engine stefanscherer/docker-cli-windows:18.03.0-ce-1709 docker version
#endregion

#region Hyper-V Containers
Set-VMProcessor -VMName wincont,lcow,win1803_lcow -ExposeVirtualizationExtensions $true -Count 2
Set-VMMemory -VMName wincont,lcow,win1803_lcow -DynamicMemoryEnabled $false
docker run -it --isolation=hyperv microsoft/nanoserver:1709 cmd
#endregion

#region Mixed Swarm
docker swarm init
New-NetFirewallRule -Name 'Docker Swarm Master' -DisplayName 'Docker' -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort 2377
# check nodes
docker service rm $(docker service ls -q)
docker node ls -q | % { docker node inspect -f "{{.ID}} {{.Description.Hostname}} {{.Description.Platform.OS}} {{.Spec.Role}} {{.Spec.Availability}}" $_ }
# explicit service creation
docker service create --name iis microsoft/iis:windowsservercore-1709
docker service create --name nginx nginx
docker service ps $(docker service ls -q)
#  using docker-compose
@"
version: '3.2'
services:
  weblin:
    image: nginx
  webwin:
    image: microsoft/iis:windowsservercore-1709
"@ | Set-Content -Path docker-compose.yml
docker stack deploy --compose-file docker-compose.yml hybridstack
docker service ps $(docker stack services hybridstack -q)
#endregion

#region LCOW
# Requires Docker for Windows 18.03 and experimental features
docker info
docker run -d microsoft/iis
docker run -d nginx
@"
version: '3.2'
services:
  weblin:
    image: nginx
  webwin:
    image: microsoft/iis:windowsservercore-1709
"@ | Set-Content -Path docker-compose.yml
# TODO: long parameters
docker-compose up -d
docker-compose ps
Start-Process "http://$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' lcow_webwin_1)"
Start-Process "http://$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' lcow_weblin_1)"
#endregion

#region Docker Remoting
New-NetFirewallRule -Name 'Docker Insecure' -DisplayName 'Docker' -Profile Any -Direction Inbound -Action Allow -Protocol TCP -LocalPort 2375
@"
{
    "hosts": [
        "npipe://",
        "tcp://0.0.0.0:2375"
    ]
}
"@ | Set-Content -Path C:\ProgramData\docker\config\daemon.json
Restart-Service -Name docker

#endregion