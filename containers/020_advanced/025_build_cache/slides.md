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

## Buildkit Cache Warming

### How it works

- Use remote images to warm cache
- Image layers will be downloaded as needed
- Same syntax using `--cache-from`
- Cache information must be embedded
- Prerequisites: Docker 19.03

--

### Demo: Buildkit Cache Warming

<!-- include: buildkit-0.command -->

<!-- include: buildkit-1.command -->

--

## Demo: Buildkit Cache Internals

<!-- include: internals-0.command -->
