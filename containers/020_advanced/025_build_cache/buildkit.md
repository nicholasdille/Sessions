## Buildkit Cache Warming

Large image downloads for few helpful layers

### How it works

Use remote images to warm cache

Image layers will be downloaded as needed

Same syntax using `--cache-from`

### Prerequisites

Added in Docker 19.03

--

## Demo: Buildkit Cache Warming

Build with cache from remote image:

```bash
# Run Docker 19.03-rc
docker run -d --rm --name dind --privileged --network host \
    --volume $(pwd):/src --workdir /src docker:19.03-rc-dind
docker exec -it dind sh

# Run inside container
apk add --update-cache --no-cache curl jq
export DOCKER_BUILDKIT=1
docker build --tag localhost:5000/test:1 \
    --build-arg BUILDKIT_INLINE_CACHE=1 .
docker push localhost:5000/test:1
docker system prune --all
docker build \
    --cache-from localhost:5000/test:1 .
```

--

## Demo: Buildkit Cache Warming

Check manifest for cache information:

```bash
curl -s \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    localhost:5000/v2/test/manifests/1 \
    | jq --raw-output '.config.digest' \
    | while read CONFIG_DIGEST; do \
        curl -s \
            -H "Accept: application/vnd.docker.container.image.v1+json" \
            localhost:5000/v2/test/blobs/${CONFIG_DIGEST} \
        | jq --raw-output '."moby.buildkit.cache.v0"' \
        | base64 -d \
        | jq; \
    done
```