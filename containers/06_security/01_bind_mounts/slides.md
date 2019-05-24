## Bind Mounts

Host directory is mapped into container

```
docker run -it --rm \
    --volume $(pwd):/src \
    alpine
```

By default container has the same UID/GID space

Permissions are enforced based on shared UID/GID

```
docker run -it --rm \
    alpine \
    whoami
```

---

## Bind Mounts

Privilege escalation:

```
docker run -it --rm \
    --volume /:/host \
    alpine
```

The `USER` statement in a `Dockerfile` can be overridden:

```
docker run -it --rm \
    --user 0:0 \
    alpine
```

XXX user namespace remapping