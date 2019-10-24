## Cloud Native Storage

XXX OCI Registry As Storage

XXX https://stevelasker.blog/2019/05/11/authoring-oci-registry-artifacts-quick-guide/

XXX https://stevelasker.blog/2019/08/08/oci-artifact-authoring-annotations-config-json/

XXX https://github.com/deislabs/oras

### Supports

- Multiple files per artifact
- Custom content types
- Config files per artifact - even with custom content type

--

## Demo: oras

```bash
# Start registry
docker run -d -p 127.0.0.1:5000:5000 registry:2

# Upload
oras push localhost:5000/img/shell:latest img.sh

# Download
oras pull localhost:5000/img/shell:latest --output out

# Check registry
curl http://localhost:5000/v2/img/shell/tags/list
curl -H "Accept: application/vnd.oci.image.manifest.v1+json" http://localhost:5000/v2/img/shell/manifests/latest
# empty config blob
DIGEST=$(curl -H "Accept: application/vnd.oci.image.manifest.v1+json" http://localhost:5000/v2/img/shell/manifests/latest | jq --raw-output '.layers[].digest')
curl -H "Accept: application/vnd.oci.image.manifest.v1+json" http://localhost:5000/v2/img/shell/blobs/${DIGEST}
```
