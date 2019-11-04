## `docker context`

Manage connections to Docker instances

```bash
docker context ls
docker context create docker-hcloud \
    --description 'Remote@Hetzner' \
    --docker 'host=ssh://docker-hcloud'
docker context use docker-hcloud
docker context ls
docker version
```

Manage connections to Kubernetes clusters

```bash
k3d create --name context --worker 3
docker context create k3d --docker 'host=unix:///var/run/docker.sock' --kubernetes config-file=$(k3d get-kubeconfig --name=context)
```

XXX purpose?!
