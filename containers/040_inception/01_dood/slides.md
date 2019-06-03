## Docker-out-of-Docker

Using the existing Docker daemon

### How it works

- Containerized Docker CLI
- Mapped Docker socket

```bash
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    docker:18.06
    docker version
```

### Disadvantages

- Conflicts with other containers
- Interferes with the host