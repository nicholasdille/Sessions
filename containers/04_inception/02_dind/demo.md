# Docker-in-Docker (dind)

Isolating a Docker daemon:

```bash
docker run -d --rm --privileged --name dind docker:stable-dind
export DOCKER_HOST="tcp://$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind):2375"
docker version
```

Also refer to security!