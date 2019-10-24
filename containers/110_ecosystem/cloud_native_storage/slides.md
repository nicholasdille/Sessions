## Cloud Native Storage

XXX OCI Registry As Storage

XXX https://stevelasker.blog/2019/05/11/authoring-oci-registry-artifacts-quick-guide/

XXX https://stevelasker.blog/2019/08/08/oci-artifact-authoring-annotations-config-json/

XXX https://github.com/deislabs/oras

```bash
# Start local registry
docker run -d -p 127.0.0.1:5000:5000 registry:2

# Push multiple files
oras push localhost:5000/img/shell:latest img.sh

# Check registry (BROKEN)
curl http://localhost:5000/v2/img/shell/tags/list
curl -H "Accept: application/vnd.oci.image.manifest.v1+json" http://localhost:5000/v2/img/shell/manifests/latest
# empty config blob
# layers are base64 encoded and encrypted with salted passwort
oras pull registry.dille.io/kubeconfig:tst --output ./output
```
