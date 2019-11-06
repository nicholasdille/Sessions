## docker-app

### What it is

De facto standard is using `docker-compose` for apps

Package and distribute using container registry

Standalone binary in version <= 0.6

Docker CLI plugin in version >= 0.7

### Further reading

Workshop by [Docker Captain Michael Irwin](https://www.docker.com/captains/michael-irwin) @ [Docker Summit 2019](https://github.com/mikesir87/docker-summit-19-docker-app-workshop)

--

## docker-app: Preparation

This is an experimental CLI feature:

```bash
export DOCKER_CLI_EXPERIMENTAL=enabled
```

Import completion:

```bash
source <(docker app completion bash)
```

Start local registry:

```bash
docker run -d -p 5000:5000 registry:2
```

--

## docker-app: Creation

Create an app stack in `registry.dockerapp`:

```bash
docker app init --single-file hello
```

Add parameters `port` and `text`

Check resulting app and upload to registry:

```bash
docker app inspect
docker app render
docker app render --set text="hello containerconf"
```

--

## docker-app: Deployment

Check app stack from registry:

```bash
docker app push --tag localhost:5000/hello:1.0
docker app inspect localhost:5000/hello:1.0
docker app render localhost:5000/hello:1.0
```

Deploy:

```bash
docker-compose down
docker app render hello | docker-compose -f - up -d
```

--

## docker-app: Internals

Stored like an image

```bash
# Image manifest
MANIFEST=$(curl -sH \
    "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    http://localhost:5000/v2/hello/manifests/1.0)

# Image configuration is boring
CONFIG=$(echo "${MANIFEST}" | jq --raw-output '.config.digest')
curl -o - \
    http://localhost:5000/v2/hello/blobs/${CONFIG} | jq

# Layer contains packaged app
LAYER=$(echo "${MANIFEST}" | jq --raw-output '.layers[0].digest')
curl -o - \
    http://localhost:5000/v2/hello/blobs/${LAYER} | tar -tvz
```
