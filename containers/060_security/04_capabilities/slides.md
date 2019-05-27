## Capabilities

XXX kernel capabilities

Add only required capabilities:

```
docker run -it --rm \
    --cap-add SYS_ADMIN \
    alpine
```

Or at least, remove unneeded capabilities:

```
docker run -it --rm \
    --cap-??? SYS_ADMIN \
    alpine
```

All capabilities is equivalent to privileged