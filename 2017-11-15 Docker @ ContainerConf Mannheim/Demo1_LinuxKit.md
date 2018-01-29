# Demo: LinuxKit

## Prepare builing Moby and LinuxKit

Clone LinuxKit and build the Mody tool:

```bash
$ mkdir ~/go
$ export $GOPATH=~/go
$ git clone https://github.com/linuxkit/linuxkit $GOPATH/src/github.com/linuxkit/linuxkit
$ make
```

## Take a look at the configuration of LinuxKit

```bash
$ cat examples/minimal.yml
```

## Build LinuxKit

The following take roughly one minute:

```bash
$ ./bin/moby build -name docker -format iso-efi ./examples/docker.yml
```

The resulting ISO can be used to boot in Hyper-V using a generation 2 VM.

## Check configuration

```bash
$ ip address
$ ps faux
$ df
$ runc list
$ ctr containers
```

## Use Docker on LinuxKit

```bash
$ ctr tasks exec --tty --exec-id docker-1 docker /bin/sh
$ docker run -it -p 9000:9000 -v “/var/run/docker.sock:/var/run/docker.sock” portainer/portainer --no-auth
```
