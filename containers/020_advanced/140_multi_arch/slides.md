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
   - linux/arm/v5
   - linux/arm/v7
   - linux/arm64/v8
   - linux/386
   - linux/ppc64le
   - linux/s390x

$ docker run mplatform/mquery openjdk:8-jdk-nanoserver
Image: openjdk:8-jdk-nanoserver
 * Manifest List: Yes
 * Supported platforms:
   - windows/amd64:10.0.14393.1770
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
   - linux/arm64/v8
   - linux/386
   - linux/ppc64le
   - linux/s390x
   - windows/amd64:10.0.14393.1770
   - windows/amd64:10.0.16299.19
```

--

## Multi-Arch Image: docker

```bash
$ docker run mplatform/mquery docker
Image: hello-world
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v5
   - linux/arm/v7
   - linux/arm64/v8
   - linux/386
   - linux/ppc64le
   - linux/s390x
   - windows/amd64:10.0.14393.1770
   - windows/amd64:10.0.16299.19
```

--

## Building for other Architectures

XXX

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

## Build multi-arch with proper tags (1)

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

## Build multi-arch with proper tags (2)

Create manifest list with all images:

```bash
docker manifest create --amend nicholasdille/hello
    nicholasdille/hello:arm \
    nicholasdille/hello:arm64 \
    nicholasdille/hello:amd64

docker manifest inspect nicholasdille/hello
```
