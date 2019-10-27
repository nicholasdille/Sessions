## k8s: Do not do bare-metal

### Bootstrapping is hard

- Use cloud provider
- Do not script yourself
- Use [kubespray](https://github.com/kubernetes-sigs/kubespray)

### Mind the focus of KthW

- Focuses on installation of k8s
- But: Docker can interfere with iptables and break DinD
- But: Some CNI plugins do not configure `portmap` and break `hostPort`

### You build it, you own it

- Your responsibility
- Load balancing is much harder
- DMZ, firewalls and company policies are in your way
- Host resources and pod eviction XXX
