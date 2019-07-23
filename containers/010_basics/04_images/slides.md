## Image management

### Images are served from Docker Hub

hub.docker.com

### Images are named user/name:tag

### Hands-on

```
$ docker pull centos
$ docker rmi centos
```

--

![](../images/Containers_like_VMs.png)

--

## Custom images

### Custom behaviour

Based on existing image

Adds tools and functionality

Simple but sufficient scripting language

### Hands-on

```
$ cat Dockerfile
FROM ubuntu:xenial
RUN apt update && apt -y install nginx

$ docker build --tag myimage .
```

--

## Image registries

### Docker Hub is not the only source for images

### Private registries based on Docker Distribution

### Hands-on

```
$ docker tag myimage nicholasdille/coolnginx
$ docker push nicholasdille/coolnginx
```

--

## Private registries

### Security

localhost:5000 is preconfigured as insecure registry

Other registries must be secure (HTTPS)

### Hands-On

```
$ docker run -d --name registry -p 5000:5000 registry
$ docker tag ubuntu localhost:5000/groot/ubuntu
$ docker push localhost:5000/groot/ubuntu
```