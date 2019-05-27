# docker-app

Home: https://github.com/docker/app

## Installation

```bash
curl -Ls https://github.com/docker/app/releases/download/v0.6.0/docker-app-linux.tar.gz | tar -xvz
mv docker-app-linux /usr/local/bin/docker-app
source <(docker-app completion bash)
```

## Preparation

Start local registry:

```bash
docker run -d -p 5000:5000 registry:2
wget https://github.com/nicholasdille/docker-lab/raw/master/advanced/docker-compose/docker-compose.yml
```

## Creation

Create an app stack:

```bash
docker-app init --single-file registry
```

Modify `cicd-env.dockerapp`, fill maintainer and add parameter `port`:

```yaml
# This section contains your application metadata.
# Version of the application
version: 0.1.0
# Name of the application
name: registry
# A short description of the application
description:
# Namespace to use when pushing to a registry. This is typically your Hub username.
#namespace: myHubUsername
# List of application maintainers with name and email for each
maintainers:
  - name: Nicholas Dille
    email: nicholas@dille.name

---
# This section contains the Compose file that describes your application services.
version: "3.2"

services:
  registry:
    image: registry:2
    ports:
      - 5000:5000
  web:
    image: konradkleine/docker-registry-frontend:v2
    environment:
      ENV_DOCKER_REGISTRY_HOST: "registry"
      ENV_DOCKER_REGISTRY_PORT: 5000
    ports:
      - ${port}:80
    depends_on:
      - registry

---
# This section contains the default values for your application settings.
port: 80
```

Check resulting app and upload to registry:

```bash
docker-app render
docker-app push registry --namespace localhost:5000 --repo registry --tag 1.0
```

# Reuse

Download to subdirectory:

```bash
docker-app fork localhost:5000/registry:1.0
```

# Deployment

Check app stack from registry:

```bash
docker-app render localhost:5000/registry:1.0
```

Deploy:

```bash
docker-compose down
docker-app render registry | docker-compose -f - up -d
```

# Internals

Stored like an image

Manifest links to boring image configuration and single layer

```bash
# Image configuration is boring
CONFIG_DIGEST=$(curl -sH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/registry/manifests/1.0 | jq --raw-output '.config.digest')
curl -o - http://localhost:5000/v2/registry/blobs/${CONFIG_DIGEST} | jq

# Layer contains packaged app
LAYER_DIGEST=$(curl -sH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/registry/manifests/1.0 | jq --raw-output '.layers[0].digest')
curl -o - http://localhost:5000/v2/registry/blobs/${LAYER_DIGEST} | tar -tvz
```