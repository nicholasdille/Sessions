FROM nicholasdille/service

SHELL [ "powershell", "-Command" ]

RUN Add-WindowsFeature -Name Web-Server; \
    Import-Module -Name IISAdministration; \
    New-Item -Path C:\\Site -ItemType Directory; \
    Copy-Item -Path C:\\inetpub\\wwwroot\\* -Destination C:\\Site; \
    Remove-IISSite -Name 'Default Web Site' -Confirm:$false; \
    New-IISSite -Name 'Site' -PhysicalPath C:\\Site -BindingInformation '*:80:'
CMD [ "w3svc" ]

EXPOSE 80
VOLUME c:\\Site
