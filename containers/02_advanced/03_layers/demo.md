# Demo for image layers

## Preparation

Upload image to local registry:

```
docker run -d -p 5000:5000 registry:2
docker build --tag localhost:5000/hello-world-java .
docker push localhost:5000/hello-world
```

## Investigate layers locally

```
docker history hello-world
```

## Image Manifest

Download image manifest:

```
curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/hello-world-java/manifests/latest
```

## Image Configuration

Download image configuration:

```
curl -sLH "Accept: application/vnd.docker.container.image.v1+json" http://localhost:5000/v2/hello-world-java/manifests/latest
```

## Download image layer

```
DIGEST=$(curl -sLH "Accept: application/vnd.docker.container.image.v1+json" http://localhost:5000/v2/hello-world-java/manifests/latest | jq --raw-output '.layers[-1].digest')
curl -sLH "Accept: application/vnd.docker.image.rootfs.diff.tar.gzip" http://localhost:5000/v2/hello-world-java/blobs/${DIGEST} | tar -tvz
```

## Verifying a layer's digest

```bash
curl -sLH "Accept: application/vnd.docker.container.image.v1+json" http://localhost:5000/v2/hello-world-java/manifests/latest | jq --raw-output '.layers[-1]'
curl -sLH "Accept: application/vnd.docker.image.rootfs.diff.tar.gzip" http://localhost:5000/v2/hello-world-java/blobs/${DIGEST} | sha256sum
```

## Determining the content length

```bash
curl -sLH "Accept: application/vnd.docker.container.image.v1+json" http://localhost:5000/v2/hello-world-java/manifests/latest | jq --raw-output '.layers[-1]'
curl -sLH "Accept: application/vnd.docker.image.rootfs.diff.tar.gzip" http://localhost:5000/v2/hello-world-java/blobs/${DIGEST} | wc -c
```

## Tagging images remotely

```bash
# Download manifest from old name
MANIFEST=$(curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" localhost:5000/v2/hello-world-java/manifests/latest)

# Push manifest with new name
curl -X PUT -H "Content-Type: application/vnd.docker.distribution.manifest.v2+json" -d "${MANIFEST}" localhost:5000/v2/hello-world-java/manifests/new

# Test
docker pull localhost:5000/v2/hello-world-java/manifests/new
```

# Further reading

[Registry API](https://docs.docker.com/registry/spec/api/)
[Image Manifest Specification v2.2](https://docs.docker.com/registry/spec/manifest-v2-2/)