#region Env
$Env:DOCKER_HOST = 'tcp://srv1.inmylab.de:2376'
$Env:DOCKER_TLS_VERIFY = 1
$Env:DOCKER_CERT_PATH = "$(Get-Location)\srv1"
$Env:PATH = "$Env:PATH;.;$PSScriptRoot"
docker -H 'tcp://srv1.inmylab.de:2376' --tlsverify --tlscacert=.\srv1\ca.pem --tlscert=.\srv1\cert.pem --tlskey=.\srv1\key.pem version
#endregion

#region Interaktives
docker images
docker run -it microsoft/windowsservercore powershell
Get-Process | Where-Object {$_.ProcessName -like 'powershell*'}
docker run -it microsoft/nanoserver powershell
docker ps -a
#endregion

#region Dienstliches
docker pull nicholasdille/iis
docker run -d -p 81:80 --name iisdemo nicholasdille/iis
docker inspect iisdemo
http://srv1.inmylab.de:81/
docker rm -f iisdemo
docker run -d -p 81:80 --name contentdemo iisteccon
docker rm -f contentdemo
ise iisteccon\Dockerfile
#endregion

#region Remote
docker info
Write-Output ('DOCKER_HOST={0} // DOCKER_TLS_VERIFY={1} // DOCKER_CERT_PATH={2}' -f $Env:DOCKER_HOST, $Env:DOCKER_TLS_VERIFY, $Env:DOCKER_CERT_PATH)
#endregion