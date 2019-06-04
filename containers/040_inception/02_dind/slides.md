## Docker-in-Docker (DinD)

Running an additional Docker daemon

### How it works

- Containerized Docker daemon
- Requires a privileged container

### Disadvantages

- Privileged containers enable host breakouts

--

## Demo: Docker-in-Docker (DinD)

Isolating a Docker daemon:

```bash
docker run -d --rm \
  --privileged \
  --name dind \
  docker:stable-dind

IP=$(
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind
)
export DOCKER_HOST="tcp://$IP:2375"

docker version
```

Also refer to security!