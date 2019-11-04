## BuildKit

*concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit*

### Relevant features

- Multi-stage builds
- Parallel builds
- Remote build cache
- Build mounts
- Build secrets
- SSH forwarding

--

## Demo: buildkit

Standalone usage of buildkit:

```bash
docker run -d -p 127.0.0.1:5000:5000 registry:2
sudo ./buildkit
buildctl build \
    --frontend=dockerfile.v0 \
    --local context=. \
    --local dockerfile=. \
    --output type=image,name=localhost:5000/test,push=true
    --export-cache type=inline \
    --import-cache type=registry,ref=localhost:5000/test
```

Working rootless [implementation](https://github.com/moby/buildkit/blob/master/docs/rootless.md)
