# Demo for using multi-stage builds for concurrency

Default `docker build` works sequentially:

```
docker build .
```

BuildKit work in parallel:

```
DOCKER_BUILDKIT=1 docker build .
```