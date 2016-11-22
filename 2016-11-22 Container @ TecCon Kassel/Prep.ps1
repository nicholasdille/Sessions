#region Generate and install certificate
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.51,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.52,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.53,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.54,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.55,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.56,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.57,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.58,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.59,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
docker run --rm -e SERVER_NAME=srv1.inmylab.de -e IP_ADDRESSES=127.0.0.1,10.0.0.60,138.201.37.93 -v "C:\ProgramData\docker:C:\ProgramData\docker" -v "C:\Users\Administrator\.docker:C:\Users\ContainerAdministrator\.docker" stefanscherer/dockertls-windows
#endregion

#region Copy certificates
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.51 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\01
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.52 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\02
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.53 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\03
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.54 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\04
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.55 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\05
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.56 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\06
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.57 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\07
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.58 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\08
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.59 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\09
Copy-Item -FromSession (New-PSSession -ComputerName 10.0.0.60 -Credential (Get-Credential administrator)) -Path c:\users\administrator\.docker\*.pem -Destination .\10
#endregion

#region Create port forwarding for docker
netsh interface portproxy add v4tov4 10001 10.0.0.51 2376
netsh interface portproxy add v4tov4 10002 10.0.0.52 2376
netsh interface portproxy add v4tov4 10003 10.0.0.53 2376
netsh interface portproxy add v4tov4 10004 10.0.0.54 2376
netsh interface portproxy add v4tov4 10005 10.0.0.55 2376
netsh interface portproxy add v4tov4 10006 10.0.0.56 2376
netsh interface portproxy add v4tov4 10007 10.0.0.57 2376
netsh interface portproxy add v4tov4 10008 10.0.0.58 2376
netsh interface portproxy add v4tov4 10009 10.0.0.59 2376
netsh interface portproxy add v4tov4 10010 10.0.0.60 2376
#endregion

#region Create port forwarding for web
netsh interface portproxy add v4tov4 10011 10.0.0.51 80
netsh interface portproxy add v4tov4 10012 10.0.0.52 80
netsh interface portproxy add v4tov4 10013 10.0.0.53 80
netsh interface portproxy add v4tov4 10014 10.0.0.54 80
netsh interface portproxy add v4tov4 10015 10.0.0.55 80
netsh interface portproxy add v4tov4 10016 10.0.0.56 80
netsh interface portproxy add v4tov4 10017 10.0.0.57 80
netsh interface portproxy add v4tov4 10018 10.0.0.58 80
netsh interface portproxy add v4tov4 10019 10.0.0.59 80
netsh interface portproxy add v4tov4 10020 10.0.0.60 80
#endregion

#region Test
docker -H 'tcp://srv1.inmylab.de:10001' --tlsverify --tlscacert=.\01\ca.pem --tlscert=.\01\cert.pem --tlskey=.\01\key.pem version
docker -H 'tcp://srv1.inmylab.de:10002' --tlsverify --tlscacert=.\02\ca.pem --tlscert=.\02\cert.pem --tlskey=.\02\key.pem version
docker -H 'tcp://srv1.inmylab.de:10003' --tlsverify --tlscacert=.\03\ca.pem --tlscert=.\03\cert.pem --tlskey=.\03\key.pem version
docker -H 'tcp://srv1.inmylab.de:10004' --tlsverify --tlscacert=.\04\ca.pem --tlscert=.\04\cert.pem --tlskey=.\04\key.pem version
docker -H 'tcp://srv1.inmylab.de:10005' --tlsverify --tlscacert=.\05\ca.pem --tlscert=.\05\cert.pem --tlskey=.\05\key.pem version
docker -H 'tcp://srv1.inmylab.de:10006' --tlsverify --tlscacert=.\06\ca.pem --tlscert=.\06\cert.pem --tlskey=.\06\key.pem version
docker -H 'tcp://srv1.inmylab.de:10007' --tlsverify --tlscacert=.\07\ca.pem --tlscert=.\07\cert.pem --tlskey=.\07\key.pem version
docker -H 'tcp://srv1.inmylab.de:10008' --tlsverify --tlscacert=.\08\ca.pem --tlscert=.\08\cert.pem --tlskey=.\08\key.pem version
docker -H 'tcp://srv1.inmylab.de:10009' --tlsverify --tlscacert=.\09\ca.pem --tlscert=.\09\cert.pem --tlskey=.\09\key.pem version
docker -H 'tcp://srv1.inmylab.de:10010' --tlsverify --tlscacert=.\10\ca.pem --tlscert=.\10\cert.pem --tlskey=.\10\key.pem version
#endregion
