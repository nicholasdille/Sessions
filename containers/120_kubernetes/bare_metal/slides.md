## k8s: Do not do bare-metal

### Bootstrapping is hard

Use cloud provider

Do not script yourself

Use [kubespray](https://github.com/kubernetes-sigs/kubespray)

### Mind the focus of KthW

Demonstrates installation of k8s

Docker interferes with iptables and breaks DinD

Some CNI plugins do not configure `portmap` and break `hostPort`
