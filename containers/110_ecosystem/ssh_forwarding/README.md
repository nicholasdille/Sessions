# SSH Agent Forwarding

Enable BuildKit:

```bash
export DOCKER_BUILDKIT=1
```

Note the command and the `--mount` parameter in `Dockerfile`!

Build image:

```bash
docker build --ssh default --progress plain .
```
