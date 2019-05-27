# Demo for architecture

Separate `dockerd` and `containerd`:

```
docker run -d --name dind --privileged docker:stable-dind
docker exec -it dind sh
ps
```

Use `containerd` independently:

```
ctr --address /run/docker/containerd/containerd.sock image pull docker.io/library/docker:stable
ctr --address /run/docker/containerd/containerd.sock image ls
```

Images are stores separately:

```
docker image ls
```