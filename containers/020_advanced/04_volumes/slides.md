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

XXX mapping is useful for development

```
docker run --user $(id -u):$(id -g) ...
```