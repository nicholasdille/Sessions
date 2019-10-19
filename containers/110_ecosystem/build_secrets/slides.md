## Build Secrets - Mounts

Enable BuildKit:

```bash
export DOCKER_BUILDKIT=1
```

Build image:

```bash
docker build \
    --secret id=mysite.key,src=./mysite.key \
    --progress plain \
    .
```

Note the comment and the `--mount` parameter in `Dockerfile`!

XXX demo file never ends up in container

XXX ref to `docker buildx`