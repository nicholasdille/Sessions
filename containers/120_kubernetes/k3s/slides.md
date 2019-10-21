## k3s: The lightweight k8s

### [k3s](https://github.com/rancher/k3s) is made by Rancher

- Removes legacy, alpha and non-default features
- Removes most plugins
- Adds sqlite3 as default configuration store
- Adds simple launcher
- Packages dependencies like containerd, flannel, CoreDNS, CNI

### Demo: SSH into fresh VM

```bash
root@k3s:~# curl -sfL https://get.k3s.io | sh -
#...
root@k3s:~# kubectl get nodes
NAME   STATUS   ROLES    AGE   VERSION
k3s    Ready    master   76s   v1.15.4-k3s.1
```

--

## k3d: k3s in Docker

### [k3d](https://github.com/rancher/k3d) is made by Rancher

- Lightweight k3s distribution
- Prerequisites: Docker

### Demo: Run on fresh Docker host

```bash
# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

# Install k3d and deploy cluster
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash
k3d create --name k3d --workers 3
export KUBECONFIG="$(k3d get-kubeconfig --name='k3d')"
kubectl cluster-info
docker ps
```

--

## k3sup provisions k3s via SSH

### [k3sup](https://github.com/alexellis/k3sup) is made by [Alex Ellis](https://github.com/alexellis)

- Deploy `k3s` on a remote host
- Join host to `k3s` cluster
- Prerequisites: SSH

*Alex is also the creator of [OpenFaaS](https://www.openfaas.com/)*

### Demo: Run against fresh remote host

```bash
# Install k3sup
curl -sLS https://get.k3sup.dev | sh

# Deploy k3s server
k3sup install \
    --context k3sup \
    --ip 78.46.246.60 \
    --user root \
    --ssh-key ~/id_rsa_hetzner
kubectl --kubeconfig=./kubeconfig get nodes -o wide
```