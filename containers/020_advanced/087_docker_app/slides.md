# docker-app

XXX https://github.com/mikesir87/docker-summit-19-docker-app-workshop

Home: https://github.com/docker/app

--

## Installation

```bash
curl -sL \
    https://github.com/docker/app/releases/download/\
    v0.6.0/docker-app-linux.tar.gz \
| tar -xvz
mv docker-app-linux /usr/local/bin/docker-app
source <(docker-app completion bash)
```

--

## Preparation

Start local registry:

```bash
docker run -d -p 5000:5000 registry:2
wget https://github.com/nicholasdille/docker-lab/raw/master/advanced/docker-compose/docker-compose.yml
```

--

## Creation

Create an app stack:

```bash
docker-app init --single-file registry
```

Modify `cicd-env.dockerapp`, fill maintainer and add parameter `port`

Check resulting app and upload to registry:

```bash
docker-app render
docker-app push registry \
    --namespace localhost:5000 \
    --repo registry \
    --tag 1.0
```

--

# Reuse

Download to subdirectory:

```bash
docker-app fork localhost:5000/registry:1.0
```

--

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

--

# Internals

Stored like an image

```bash
# Image manifest
MANIFEST=$(curl -sH \
    "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    http://localhost:5000/v2/registry/manifests/1.0)

# Image configuration is boring
CONFIG=$(echo "${MANIFEST}" | jq --raw-output '.config.digest')
curl -o - \
    http://localhost:5000/v2/registry/blobs/${CONFIG} | jq

# Layer contains packaged app
LAYER=$(echo "${MANIFEST}" | jq --raw-output '.layers[0].digest')
curl -o - \
    http://localhost:5000/v2/registry/blobs/${LAYER} | tar -tvz
```
