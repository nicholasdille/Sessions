## k8s: Tools

### kubectl explain

- Check fields of API objects

```bash
kubectl explain deployment
kubectl explain deployment.spec
```

### [kubectx / kubens](https://github.com/ahmetb/kubectx)

- `kubectx` switches context
- `kubens` switches namespace

--

## k8s: Tools

### [kube-capacity](https://github.com/robscott/kube-capacity)

- Display resource usage, requests and limits
- Prerequisites: k8s metrics server

Demo: Run against k8s/k3s cluster:

```bash
curl -sLf \
    https://github.com/robscott/kube-capacity/releases/download/0.3.2/kube-capacity_0.3.2_Linux_x86_64.tar.gz \
| tar -xvz -C /usr/local/bin/ kube-capacity
kube-capacity
kube-capacity --containers
```
