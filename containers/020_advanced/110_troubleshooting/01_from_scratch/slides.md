## Troubleshooting `FROM scratch`

### Missing tools

- Containers only contain a single binary
- No shell, no tools

### Solution: Dump root partition content into container

```bash
# Container with image FROM scratch
docker run -d --name traefik traefik:v1.7

# Create local rootfs
docker create --name alpine alpine
docker cp alpine:/ .

# Copy into container
rm /etc/hosts /etc/hostname /etc/resolv.conf
docker cp . traefik:/

# Enter container
docker exec -it traefik /bin/sh
```
