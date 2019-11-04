## Cloud Native Storage

### OCI Registry As Storage

- Generalize artifact store
- Based on registry, e.g. Docker registry

### Supports

- Multiple files per artifact
- Custom content types
- Config files per artifact - even with custom content type

### Official guides

- [Authoring](https://stevelasker.blog/2019/05/11/authoring-oci-registry-artifacts-quick-guide/) OCI registry artifacts
- [Annotations and Configurations](https://stevelasker.blog/2019/08/08/oci-artifact-authoring-annotations-config-json/) in artifacts

--

## Demo: oras

Test command line tool [oras](https://github.com/deislabs/oras)

```bash
# Start registry
docker run -d -p 127.0.0.1:5000:5000 registry:2

# Create artifact
echo blarg >artifact.txt

# Upload
oras push localhost:5000/test:latest artifact.txt

# Download
oras pull localhost:5000/test:latest --output out
```

--

## Demo: oras Internals

Check contents of registry:

```bash
# Check registry
curl http://localhost:5000/v2/test/tags/list
curl -H "Accept: application/vnd.oci.image.manifest.v1+json" \
    http://localhost:5000/v2/test/manifests/latest

# Get content
DIGEST=$(curl -H "Accept: application/vnd.oci.image.manifest.v1+json" \
    http://localhost:5000/v2/test/manifests/latest \
    | jq --raw-output '.layers[].digest')
curl -H "Accept: application/vnd.oci.image.manifest.v1+json" \
    http://localhost:5000/v2/test/blobs/${DIGEST}
```
