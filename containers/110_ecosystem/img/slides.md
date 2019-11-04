## Image building

### kaniko

- [Kaniko](https://github.com/GoogleContainerTools/kaniko) created by Google
- Daemonless, unprivileged
- Uses Dockerfile

### buildah

- [Buildah](https://github.com/containers/buildah) created by RedHat
- Daemonless, unprivileged
- Script/command based (not using Dockerfile)

### img

- [img](https://github.com/genuinetools/img) created by [Jessie Frazelle](https://blog.jessfraz.com/)
- Based on buildkit
- Daemonless, unprivileged
- Uses Dockerfile

--

## Demo: img (1)

Create a pod with multiple containers using `docker`:

```bash
docker run -d --name pod alpine \
    sh -c 'while true; do sleep 10; done'
docker run -d --name registry \
    --pid container:pod --network container:pod registry:2
docker run -d --name img \
    --pid container:pod --network container:pod \
    --mount type=bind,source=$(pwd),target=/src --workdir /src \
    --security-opt seccomp=unconfined \
    --security-opt apparmor=unconfined \
    --entrypoint sh r.j3ss.co/img:v0.5.7 \
    -c 'while true; do sleep 10; done'
docker exec --user 0 img apk add --update-cache curl git bash
```

--

## Demo: img (2)

Building and pushing using `img`:

```bash
docker exec -it img bash
img build --tag localhost:5000/test .
img push --insecure-registry localhost:5000/test
```
