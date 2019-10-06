## OCI Registry As Storage

XXX https://github.com/deislabs/oras

```bash
# Start local registry
docker run -d -p 5000:5000 registry:2

# Push multiple files
oras push localhost:5000/buildx:latest hello.c Dockerfile

# Check registry (BROKEN)
curl http://localhost:5000/v2/buildx/tags/list
curl -H "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/buildx/manifests/latest
```