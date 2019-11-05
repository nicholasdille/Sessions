## Cloud Native Application Bundle

[CNAB](https://cnab.io/) is a standard packaging format for multi-component distributed applications

### Features

1. Single logical unit (app)
1. Lifecycle management (install, upgrade, uninstall)
1. Digital signatures for bundles
1. Digital signatures for lifecycle state
1. Support for air gapped environments
1. Distribution

### Specification

- Core spec addresses features 1, 2, 6
- Registry spec address features 5, 6
- Security spec addresses features 3, 4
- [All specifications](https://github.com/deislabs/cnab-spec)

--

## CNAB reference implementation

Easily create bundles with [Duffle](https://github.com/deislabs/duffle)

XXX containerized install script with parameters `install|uninstall|upgrade|downgrade|status`

XXX directory layout

```
.
├── bundle.json
├── cnab
│   ├── app
│   │   └── run
│   └── Dockerfile
└── duffle.json
```

XXX addon for `vscode`: https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.duffle-vscode

XXX demo of example

```bash
git clone https://github.com/deislabs/duffle
cd duffle
duffle build ./examples/helloworld/
duffle bundle list
duffle install helloworld-demo helloworld:0.1.1
duffle list
duffle uninstall helloworld-demo
```

XXX https://github.com/deislabs/example-bundles

XXX fresh start

```bash
duffle create foo
```

--

## CNAB Installer

Interface with Helm, Terraform etc. using [Porter](https://porter.sh/)

XXX containerized installer

XXX executes commands defined in `porter.yaml`

XXX mixins provide interfaces 

XXX publish to OCI registry

XXX use CNAB compliant tool to install from registry

XXX examples: https://github.com/deislabs/porter/tree/master/examples

XXX demo

```bash
porter create
porter build
porter publish
porter install instance-name --tag user/image:tag
```

--

## CNAB Registries

Uses OCI registries as storage

[`cnab-to-oci`](https://github.com/docker/cnab-to-oci) manages bundles in registries

XXX demo

```bash
git clone https://github.com/docker/cnab-to-oci
cd cnab-to-oci
cnab-to-oci push examples/helloworld-cnab/bundle.json --target myhubusername/repo
cnab-to-oci pull myhubusername/repo@sha256:6cabd752cb01d2efb9485225baf7fc26f4322c1f45f537f76c5eeb67ba8d83e0
# what is this below?!
cnab-to-oci fixup examples/helloworld-cnab/bundle.json --target myhubusername/repo
```
