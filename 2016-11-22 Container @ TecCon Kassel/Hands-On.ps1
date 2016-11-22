#region Interaktives
docker images
docker run -it microsoft/windowsservercore powershell
Get-Process | Where-Object {$_.ProcessName -like 'powershell*'}
docker run -it microsoft/nanoserver powershell
docker ps -a
#endregion

#region Dienstliches
docker pull nicholasdille/iis
docker run -d -p 80:80 --name iisdemo nicholasdille/iis
http://srv1.inmylab.de:81/
docker rm -f iisdemo
docker run -d -p 80:80 --name contentdemo iisteccon
docker rm -f contentdemo
ise iisteccon\Dockerfile
#endregion

#region Build
ise iis\Dockerfile
ise service\Dockerfile
docker build --name nicholasdille/iis iis
docker run -d --name iisdemo nicholasdille/iis
docker logs iisdemo
#endregion

#region Run
docker run -d --rm --name iis -p 80:80 nicholasdille/iis
docker inspect iis
docker stop iis
#endregion

#region Push
docker push nicholasdille/iis
#endregion

#region Compose
Invoke-WebRequest -Uri 'https://github.com/docker/compose/releases/download/1.9.0/docker-compose-Windows-x86_64.exe' -OutFile ".\docker-compose.exe" -UseBasicParsing
docker-compose up
#endregion