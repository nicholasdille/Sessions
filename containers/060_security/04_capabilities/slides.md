## Capabilities

XXX kernel capabilities

Add only required capabilities:

```bash
docker run -it --rm \
    --cap-add SYS_ADMIN \
    alpine
```

Or at least, remove unneeded capabilities:

```bash
docker run -it --rm \
    --cap-drop SYS_ADMIN \
    alpine
```

All capabilities is equivalent to privileged