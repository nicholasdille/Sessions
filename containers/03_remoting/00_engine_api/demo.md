# Engine API

Substitute `docker version`:

```bash
curl --unix-socket /var/run/docker.sock http:/version
```

If `curl` is missing:

```bash
docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock nathanleclaire/curl curl -s --unix-socket /var/run/docker.sock http:/version
```