## Docker-in-Docker

### How it works

- Containerized Docker daemon
- Requires a privileged container

```
docker run -d --rm --privileged --name dind docker:stable-dind
export HOST_IP=$(
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind
)
export DOCKER_HOST="tcp://${HOST_IP}:2375"
docker version
```

### Disadvantages

- Privileged containers enable host breakouts