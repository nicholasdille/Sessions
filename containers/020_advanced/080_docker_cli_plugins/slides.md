## Docker CLI Plugins

Extend `docker` CLI with new sub commands

Located in `~/.docker/cli-plugins`

Executable file called `docker-<command>`

Command line parameters are passed as parameters

Plugin must provide metdata using parameter `docker-cli-plugin-metadata`, e.g.

```json
{
    "SchemaVersion":"0.1.0",
    "Vendor":"Nicholas Dille",
    "Version":"0.0.1",
    "ShortDescription":"Sample metadata",
    "URL":"https://dille.name"
}
```

--

## Demo: Docker CLI Plugins

Place `docker-distribution` in `~/.docker/cli-plugins`:

```bash
mkdir -p ~/.docker/cli-plugins
cp docker-distribution ~/.docker/cli-plugins
chmod +x ~/.docker/cli-plugins/docker-distribution
```

XXX

```bash
docker
docker distribution
```

--

## Demo: Docker CLI Plugins

Prepare local registry:

```bash
mkdir -p auth
docker run --entrypoint htpasswd registry:2 \
    -Bbn testuser testpassword > auth/htpasswd
docker run -d -p 127.0.0.1:5000:5000 --name registry \
    --mount type=bind,source=$(pwd)/auth,target=/auth \
    --env REGISTRY_AUTH=htpasswd \
    --env REGISTRY_AUTH_HTPASSWD_REALM=registry \
    --env REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
    registry:2
```

Test against local registry:

```bash
docker pull alpine
docker tag alpine localhost:5000/alpine
docker push localhost:5000/alpine
docker distribution list-tags localhost:5000/alpine
```

--

## Docker Client Plugins Manager (CLIP)

[CLIP](https://github.com/lukaszlach/clip) created by [Docker Captain Łukasz Lach](https://www.docker.com/captains/%C5%82ukasz-lach)

### How it works

Framework for running containerized client plugins

Distributed using Docker registry

### Plugin list

expose, publish, showcontext, microscan, dive, runlike, sh, hello

--

## Demo: Docker Client Plugins Manager (CLIP)

Install CLIP:

```bash
cd ~/.docker/cli-plugins
FILEPATH=lukaszlach/clip/master/docker-clip
curl -sLfO https://raw.githubusercontent.com/${FILEPATH}
chmod +x docker-clip
```

Test plugin for `dive`:

```bash
docker clip add lukaszlach/clips:dive
docker clip ls
docker dive localhost:5000/alpine
```
