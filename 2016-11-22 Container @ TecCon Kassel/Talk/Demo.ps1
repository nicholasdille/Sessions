docker pull nicholasdille/iis
docker run -d -p 80:80 --name iisdemo nicholasdille/iis
# browser
docker rm -f iisdemo
# broweser to www
docker run -d -p 80:80 -v .\www:c:\site --name contentdemo nicholasdille/iis