## Docker-out-of-Docker

### How it works

- Containerized Docker CLI
- Mapped Docker socket

```
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    docker:18.06
    docker version
```

### Disadvantages

- Conflicts with other containers
- Interferes with the host