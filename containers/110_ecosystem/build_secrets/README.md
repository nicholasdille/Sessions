# Build Secrets

Enable BuildKit:

```bash
export DOCKER_BUILDKIT=1
```

Note the comment and the `--mount` parameter in `Dockerfile`!

Build image:

```bash
docker build --secret id=mysite.key,src=./mysite.key --progress plain .
```
