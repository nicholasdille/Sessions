FROM nicholasdille/service

SHELL [ "powershell", "-Command" ]

#RUN New-Item -Path C:\Site -ItemType Directory; \
#    Add-WindowsFeature -Name Web-Server; \
#    Import-Module -Name IISAdministration; \
#    Remove-IISSite -Name "Default" -Force; \
#    New-IISSite -Name "Site" -PhysicalPath C:\Site -BindingInformation "*:80:"
CMD [ "w3svc" ]

EXPOSE 80
#VOLUME [ "c:\\Site" ]
VOLUME [ "c:\\inetpub\wwwroot" ]