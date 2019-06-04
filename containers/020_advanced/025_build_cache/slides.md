## Build Cache

Image builds can take some time

### How it works

Images are made of layers defined by...

1. Upstream layer
1. Command executed

Build cache speeds up consecutive builds

### Example

```
Step 7/11 : ADD entrypoint.sh /
 ---> Using cache
 ---> a6b2bb261372
```

--

## Demo: Build Cache

1. First build
1. Consecutive build
1. Build after changes

---

## Build Cache Warming v1

Builds may not not run on the same host

### How it works

Use local images to warm cache

```
docker pull myimage:1
docker build --cache-from myimage:1 --tag myimage:2
```

### Prerequisites

Added in Docker 1.13

Image must be present locally

--

## Demo: Build Cache Warming v1

1. Push image
1. Reset Docker
1. Pull image
1. Build with cache from local image

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

1. Reset Docker
1. Build with cache from remote image