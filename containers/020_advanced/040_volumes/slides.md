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

## File Permissions

Bind mounts are useful for development:

```
docker run \
    --mount type=bind,source=$(pwd),target=/src \
    --workdir /src \
    --user $(id -u):$(id -g) \
    maven
```

XXX