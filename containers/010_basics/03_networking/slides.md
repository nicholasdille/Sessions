## Network internals

![](../images/Network.png)

Daemon controls 172.16.0.0/12

Containers are assigned a local IP address

Outgoing traffic is translated (source NAT)

Containers are not reachable directly

Incoming traffic requires published port

Published ports are mapped from the host to the container

Only one container can use a published port

--

## Network hands-on

```
$ ifconfig docker0
$ docker run –d --name nginx1 nginx
$ docker run -d --name nginx2 -p 80:80 nginx
$ docker ps
```