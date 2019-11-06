## Troubleshooting `FROM scratch`

### Missing tools

- Modern containers only contain a single binary
- No shell, no tools

### Solution: Dump root partition content into container

```bash
# Container with image FROM scratch
docker run -d --name traefik traefik:v1.7
# Create local rootfs
mkdir rootfs
docker create --name alpine alpine
docker cp alpine:/ rootfs
# Copy into container
rm rootfs/etc/hosts rootfs/etc/hostname rootfs/etc/resolv.conf
cd rootfs && docker cp . traefik:/ && cd ..
# Enter container
docker exec -it traefik /bin/sh
```
