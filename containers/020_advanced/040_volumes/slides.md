## Volume Management

### Bind mount

- Map a local directory into the container
- Easy to exchange data with non-containerized processes
- Remote bind mount to not work

### Volume

- Managed by Docker daemon
- Works well for processing data from containers only

### tmpfs

- Real temporary data
- Removed with containers

---

## Bind Mounts

Map host-local directory into container

### Old syntax

```bash
docker run --volume $(pwd):/src alpine
```

Silently creates source if it does not exist

### New syntax

```bash
docker run --mount type=bind,source=$(pwd),target=/src alpine
```

Throws error if source does not exist

---

## File Permissions

Bind mounts are useful for development:

```bash
docker run \
    --mount type=bind,source=$(pwd),target=/src \
    --workdir /src \
    maven
```

But this creates root-owned files

Fix file permissions:

```bash
docker run \
    --mount type=bind,source=$(pwd),target=/src \
    --workdir /src \
    --user $(id -u):$(id -g) \
    maven
```