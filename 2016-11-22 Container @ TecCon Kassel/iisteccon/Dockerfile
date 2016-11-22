FROM nicholasdille/iis

SHELL [ "powershell", "-Command" ]

ADD www c:/windows/temp/www
RUN Copy-Item -Path c:/windows/temp/www/* c:/inetpub/wwwroot