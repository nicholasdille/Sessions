## Image building using img

### kaniko

- https://github.com/GoogleContainerTools/kaniko
- daemonless
- running in userspace
- uses Dockerfile

### buildah

- https://github.com/containers/buildah
- script based
- not using Dockerfile
- much more complex

### img

- daemonless
- unprivileged
- uses Dockerfile

--

## Demo: img (1)

Create a pod with multiple containers using `docker`:

```bash
#!/bin/bash
set -o errexit

if ! docker ps --filter name=pod --format "{{.Names}}" | grep --quiet pod; then
    echo Creating pod
    docker run -d --name pod alpine sh -c 'while true; do sleep 10; done'
fi

if ! docker ps --filter name=registry --format "{{.Names}}" | grep --quiet registry; then
    echo Creating registry
    docker run -d --name registry --pid container:pod --network container:pod registry:2
fi

if ! docker ps --filter name=img --format "{{.Names}}" | grep --quiet img; then

    if docker ps --all --filter name=img --format "{{.Names}}" | grep --quiet img; then
        echo Removing img
        docker rm img
    fi

    echo Creating img
    docker run -d --name img --pid container:pod --network container:pod --mount type=bind,source=$(pwd),target=/src --workdir /src --security-opt seccomp=unconfined --security-opt apparmor=unconfined --entrypoint sh r.j3ss.co/img:v0.5.7 -c 'while true; do sleep 10; done'
fi

docker exec --user 0 img apk add --update-cache curl git bash
```

### Demo: img (2)

Building and pushing using `img`:

```bash
docker exec -it img bash
img build --tag localhost:5000/test .
img push --insecure-registry localhost:5000/test
```
