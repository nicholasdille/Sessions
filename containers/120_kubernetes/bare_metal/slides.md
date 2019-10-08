## Do not do bare-metal

### Bootstrapping is hard

Use cloud provider

Do not script yourself

Use kubespray

### Mind the focus of KthW

Docker interferes with iptables and breaks DinD

Some CNI plugins do not configure `portmap` and break `hostPort`
