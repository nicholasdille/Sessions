## docker-app

https://github.com/docker/app

Standalone binary in version <= 0.6

Docker CLI plugin in version >= 0.7

XXX https://github.com/mikesir87/docker-summit-19-docker-app-workshop

--

## docker-app: Installation

```bash
curl -sL \
    https://github.com/docker/app/releases/download/v0.9.0-zeta1/docker-app-linux.tar.gz \
| tar -xvz
mv docker-app-plugin-linux ~/.docker/cli-plugins/docker-app
export DOCKER_CLI_EXPERIMENTAL=enabled
```

--

## docker-app:Preparation

Start local registry:

```bash
docker run -d -p 5000:5000 registry:2
```

XXX example

--

## docker-app:Creation

Create an app stack:

```bash
docker app init --single-file registry
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

# docker-app:Reuse

Download to subdirectory:

```bash
docker-app fork localhost:5000/registry:1.0
```

--

# docker-app:Deployment

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

# docker-app:Internals

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
