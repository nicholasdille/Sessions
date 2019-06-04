## Docker CLI Plugins

Extend `docker` with new functionality

Located in `~/.docker/cli-plugins`

Executable file called `docker-*` where `*` is the new command

Command line parameters are passed to `docker-*`

Plugin must support parameter `docker_cli_plugin_metadata` and return the following

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

Place `docker_distribution` in `~/.docker/cli-plugins`

### Prepare:

```
docker build --tag cli-plugin .
```

### Enter container and test:

```
docker
```

---

## Docker Client Plugins Manager (CLIP)

Created by [Docker Captain Łukasz Lach](https://www.docker.com/captains/%C5%82ukasz-lach)

See [GitHub](https://github.com/lukaszlach/clip)

### How it works

Framework for running containerized client plugins

Distributed using Docker registry

### Plugin list

expose, publish, showcontext, microscan, dive, runlike, sh, hello

--

## Demo: CLIP

XXX