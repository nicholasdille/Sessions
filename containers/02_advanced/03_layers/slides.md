## Layers

### Naming scheme

- Format: `<registry>/<repository>:<tag>`
- `<repository>` describes purpose
- `<tag>` describes variant or version
- `<repository>:<tag>` is called an image

### Docker Hub

- On Docker Hub: `<repository>:<tag>`
- Official image: `alpine:stable`
- Community image: `nicholasdille/insulatr`

### Images and layers

- Images consist of layers
- Layers improve download performance
- Layers enable reusability

---

## Image Manifest

### Layers

- Lists layers in the image
- Layers are referenced as blobs
- References are SHA256 hashed: `sha256:...`

### Image configuration

- Contains command used to create layers
- Stored as blob

---

## Registries

XXX