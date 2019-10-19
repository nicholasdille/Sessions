## k3s: The lightweight k8s

XXX [k3s](https://github.com/rancher/k3s)

XXX uses systemd-user

```bash
hcloud server create --name k3s --location fsn1 --image ubuntu-18.04 --ssh-key 209622 --type cx21
```

XXX ssh and continue

```bash
root@k3s:~# curl -sfL https://get.k3s.io | sh -
root@k3s:~# type kubectl
kubectl is hashed (/usr/local/bin/kubectl)
root@k3s:~# ls -l /usr/local/bin/kubectl
lrwxrwxrwx 1 root root 3 Oct 19 17:12 /usr/local/bin/kubectl -> k3s
root@k3s:~# kubectl get nodes
NAME   STATUS   ROLES    AGE   VERSION
k3s    Ready    master   76s   v1.15.4-k3s.1
```

--

## k3d is k3s in Docker

XXX [k3d](https://github.com/rancher/k3d)

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash
k3d create --name k3d --workers 3
export KUBECONFIG="$(k3d get-kubeconfig --name='k3d')"
kubectl cluster-info
```

--

## k3sup provisions k3s via SSH

XXX [k3sup](https://github.com/alexellis/k3sup)

```bash
curl -sLS https://get.k3sup.dev | sh
hcloud server create --name k3sup --location fsn1 --image ubuntu-18.04 --ssh-key 209622 --type cx21
k3sup install --context k3sup --ip 78.46.246.60 --user root --ssh-key ~/id_rsa_hetzner
kubectl --kubeconfig=./kubeconfig get nodes -o wide
```