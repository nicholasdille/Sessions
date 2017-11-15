# Demo: containerd

Command line tool `ctr`

## Pull image

```bash
$ ctr pull docker.io/library/alpine:3.6
```

## Run image

```bash
$ ctr run -t docker.io/library/alpine:3.6 test /bin/sh
```

## Remove container

```bash
$ ctr containers rm test
```

## Use docker from getty

```bash
$ alias docker=“ctr tasks exec --exec-id docker-$$ docker docker“
$ docker version
$ docker image pull alpine:3.6
$ docker container run -it alpine:3.6 sh
```

## Look at amespaces

```bash
$ lsns
```

## Looking at runc

On ubuntu:

```bash
$ apt-get -y install runc
$ docker export $(docker container create alpine:3.6) > alpine.tar
$ mkdir -p alpine/rootfs
$ cd alpine
$ tar -C rootfs -xvf ../alpine.tar
$ runc spec
$ runc run alpine
$ sudo runc list
```