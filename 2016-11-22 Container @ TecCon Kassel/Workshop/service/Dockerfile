FROM microsoft/windowsservercore

SHELL [ "powershell", "-Command" ]

ADD Test-Service.ps1 C:\
ENTRYPOINT [ "c:\\Test-Service.ps1", "-ServiceName" ]