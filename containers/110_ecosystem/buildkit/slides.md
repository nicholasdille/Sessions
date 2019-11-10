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

### Standalone usage of buildkit:

<!-- include: buildkit-0.command -->

<!-- include: buildkit-1.command -->

<!-- include: buildkit-2.command -->

Working rootless [implementation](https://github.com/moby/buildkit/blob/master/docs/rootless.md)

[Custom frontends](https://matt-rickard.com/building-a-new-dockerfile-frontend/) for buildkit