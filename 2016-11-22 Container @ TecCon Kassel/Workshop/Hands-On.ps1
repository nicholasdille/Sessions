#region Build
ise iis\Dockerfile
docker build --name nicholasdille/iis iis 
#endregion

#region Run
docker run -d -p 80:80 -v ..\www:C:\Site nicholasdille/iis
# browser
#endregion

#region Push
docker push nicholasdille/iis
#endregion