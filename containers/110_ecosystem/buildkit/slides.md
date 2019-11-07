## BuildKit

*concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit*

### The project

- Initiated by Docker
- Community driven

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
# Start local registry
docker run -d -p 127.0.0.1:5000:5000 registry:2

# Start buildkit daemon
sudo buildkitd &

# Run equivalent of docker build
buildctl build \
    --frontend=dockerfile.v0 \
    --local context=. \
    --local dockerfile=. \
    --output type=image,name=localhost:5000/test,push=true
```

Working rootless [implementation](https://github.com/moby/buildkit/blob/master/docs/rootless.md)

[Custom frontends](https://matt-rickard.com/building-a-new-dockerfile-frontend/) for buildkit