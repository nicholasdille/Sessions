# Resource Management

[Limit memory and CPU](https://docs.docker.com/config/containers/resource_constraints/)

## Memory

Reservation: `--memory-reservation`

Limit: `--memory`

Example:

```bash
docker run -d --memory-reservation 500m --memory 1g nginx
```

Also kernel memory (`--kernel-memory`) and swap (`--memory-swap` and `--memory-swapiness`).

## CPU

Assign CPUs:

```bash
docker run -d --cpus=1.5 nginx
```

Assign CPU shares:

```bash
docker run -d --cpu-shars=1024 nginx
```

## Out-of-memory killer

Disable the OOM killer:

```bash
docker run -d --oom-kill-disable nginx
```