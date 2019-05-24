# SSH

Introduced in Docker 18.09:

```bash
docker -H ssh://user@host version
```

Also works against older Docker engines if `user@host` has the updated Docker CLI in the path:

(Thanks to Brandon Mitchell [@sudo_bmitch](https://twitter.com/sudo_bmitch))

```bash
#!/bin/sh
set -e

mkdir -p $HOME/bin
curl -sL https://download.docker.com/linux/static/stable/x86_64/docker-18.09.0.tgz | tar -xvz -C $HOME/bin --strip-components=1 docker/docker
```

Test containerized:

```bash
docker run -d --rm --volume /root/.ssh:/root/.ssh --privileged nicholasdille/docker-ssh:18.09
docker run -it --rm --volume /root/.ssh:/root/.ssh docker:18.09
apk --update --no-cache openssh
exit
docker -H ssh://user@1.2.3.4 version
```