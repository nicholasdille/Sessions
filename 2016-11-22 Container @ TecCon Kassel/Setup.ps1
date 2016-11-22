#region Prepare
Set-Location -Path c:\
git clone https://github.com/nicholasdille/Sessions.git
Set-Location -Path '.\Sessions\2016-11-22 Container @ TecCon Kassel'
#endregion

#region Build container host (server / stable release)
Add-WindowsFeature -Name Containers -Restart
Install-PackageProvider -Name NuGet -Force
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
# The following requires KB3176936
Install-Package -Name docker -ProviderName DockerMsftProvider
Start-Service -Name docker
#endregion

#region Build container host (client / bleeding edge)
Invoke-WebRequest "https://master.dockerproject.org/windows/amd64/docker-1.13.0-dev.zip" -OutFile "$env:TEMP\docker-1.13.0-dev.zip" -UseBasicParsing
Expand-Archive -Path "$env:TEMP\docker-1.13.0-dev.zip" -DestinationPath $env:ProgramFiles
$env:path += ";c:\program files\docker"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
dockerd --register-service
'{"hosts": ["npipe://", "tcp://0.0.0.0:2375"]}' | Set-Content -Path 'C:\ProgramData\docker\config\daemon.json' -Force
Start-Service Docker
Set-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers' -Name VSmbDisableOplocks -Type DWord -Value 0 -Force
#endregion

#region TLS
# https://stefanscherer.github.io/protecting-a-windows-2016-docker-engine-with-tls/
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.51,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
#endregion

#region Nested Virtualization
Add-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
Set-VMProcessor -VMName hv-01 -ExposeVirtualizationExtensions $true -Count 2
Set-VMMemory -VMName hv-01 -DynamicMemoryEnabled $false
Get-VMNetworkAdapter -VMName hv-01 | Set-VMNetworkAdapter -MacAddressSpoofing On
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
