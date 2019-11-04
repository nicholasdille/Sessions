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

XXX examples: https://github.com/deislabs/duffle/tree/master/examples

XXX addon for `vscode`: https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.duffle-vscode

XXX demo

--

## CNAB Installer

Interface with Helm, Terraform etc. using [Porter](https://porter.sh/)

XXX examples: https://github.com/deislabs/porter/tree/master/examples

XXX demo

--

## CNAB Registries

Uses OCI registries as storage

[`cnab-to-oci`](https://github.com/docker/cnab-to-oci) manages bundles in registries

XXX demo?
