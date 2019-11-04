## Multi-Arch Image

### Image only work on a single platform

But containers are supported on multiple architectures and operating systems

### Virtual images to the rescue

Manifest links to multiple images for supported platforms

Now integrated in Docker CLI (docker manifest)

Based on manifest-tool (by Docker Captain Phil Estes)

### Official images are already multi-arch

--

## Multi-Arch Image: openjdk

```bash
$ docker run mplatform/mquery openjdk:8-jdk
Image: openjdk:8-jdk
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - windows/amd64:10.0.17763.805
   - windows/amd64:10.0.17134.1069
   - windows/amd64:10.0.14393.3274
$ docker run mplatform/mquery openjdk:8-jdk-nanoserver
Image: openjdk:8-jdk-nanoserver
 * Manifest List: Yes
 * Supported platforms:
   - windows/amd64:10.0.17763.802
   - windows/amd64:10.0.17134.1069
```

--

## Multi-Arch Image: hello-world

```bash
$ docker run mplatform/mquery hello-world
Image: hello-world
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v5
   - linux/arm/v7
   - linux/arm64
   - linux/386
   - linux/ppc64le
   - linux/s390x
   - windows/amd64:10.0.17134.1069
   - windows/amd64:10.0.17763.802
```

--

## Multi-Arch Image: docker

```bash
$ docker run mplatform/mquery docker
Image: docker
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v6
   - linux/arm/v7
   - linux/arm64
```

--

## Demo: Building for other Architectures

New sub command `buildx`:

```bash
# enable experimental mode for client and enable qemu
export DOCKER_CLI_EXPERIMENTAL=enabled
docker run --rm --privileged \
    docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3

# build multi-arch
docker buildx build \
    --platform linux/arm,linux/arm64,linux/amd64 \
    --tag nicholasdille/hello \
    . \
    --push

# Inspect result
docker buildx imagetools inspect nicholasdille/hello
```

--

## Demo: Build multi-arch with proper tags (1)

Build individual images to control tagging

```bash
# arm
docker buildx build --platform linux/arm \
    --tag nicholasdille/hello:arm . --push
# arm64
docker buildx build --platform linux/arm64 \
    --tag nicholasdille/hello:arm64 . --push
# amd64
docker buildx build --platform linux/amd64 \
    --tag nicholasdille/hello:amd64 . --push
```

This allows for proper versioning

--

## Demo: Build multi-arch with proper tags (2)

Create manifest list with all images:

```bash
docker manifest create --amend nicholasdille/hello
    nicholasdille/hello:arm \
    nicholasdille/hello:arm64 \
    nicholasdille/hello:amd64

docker manifest inspect nicholasdille/hello
```
