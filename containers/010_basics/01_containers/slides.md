## My First Contaienr

### Hands-on

```
$ docker run -it ubuntu
root@12345678# hostname
root@12345678# whoami
root@12345678# ps faux
root@12345678# ls –l /
root@12345678# exit
$ docker run -it ubuntu ping localhost
```

XXX interactive

--

## Background containers

### First process keeps container alive

### Containers are not purged automatically

### Hands-on

```
$ docker run -it ubuntu hostname
$ docker run –d ubuntu ping localhost
$ docker ps
$ docker stop <NAME>
$ docker rm <NAME>
```

--

## Exploration

### Name containers

```
$ docker run -d --name websrv nginx
$ docker ps
```

### Learn about containers

```
$ docker logs websrv
$ docker inspect websrv
```

XXX id

### Execute commands inside containers

```
$ docker exec websrv ps faux
$ ps faux
```

### Enter containers interactively

```
$ docker exec -it websrv bash
```