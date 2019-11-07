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

--

## `docker context`

Manage connections to Kubernetes clusters

```bash
k3d create --name context --worker 3
KUBECONFIG=$(k3d get-kubeconfig --name=context)
docker context create k3d \
    --docker 'host=unix:///var/run/docker.sock' \
    --kubernetes config-file=${KUBECONFIG}
```
