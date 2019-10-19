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
