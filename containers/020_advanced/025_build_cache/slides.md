## Build Cache

Image builds can take some time

### How it works

Images are made of layers defined by...

1. Upstream layer
1. Command executed

Build cache speeds up consecutive builds

### Example

```bash
Step 7/11 : ADD entrypoint.sh /
 ---> Using cache
 ---> a6b2bb261372
```

--

## Demo: Build Cache

1. First build
1. Consecutive build
1. Build after changes to `Dockerfile`

---

## Build Cache Warming v1

Builds may not not run on the same host

### How it works

Use local images to warm cache

```
docker pull myimage:1
docker build --cache-from myimage:1 --tag myimage:2
```

Internal build cache is ignored when using `--cache-from`

### Prerequisites

Added in Docker 1.13

Image must be present locally

--

## Demo: Build Cache Warming v1

```bash
# Push image
docker run -d -p 5000:5000 registry:2
docker build --tag localhost:5000/hello-world-java .
docker push localhost:5000/hello-world-java

# Reset Docker
docker system prune --all

# Pull image
docker pull localhost:5000/hello-world-java

# Build with cache from local image
docker build --cache-from localhost:5000/hello-world-java .
```

Internal build cache is still used when cache image does not exist

---

## Build Cache Warming v2

Large image downloads for few helpful layers

### How it works

Use remote images to warm cache

Image layers will be downloaded as needed

Same syntax using `--cache-from`

### Prerequisites

Added in Docker 19.03

--

## Demo: Build Cache Warming v2

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

## Demo: Build Cache Warming v2

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