## Cloud Native Storage

XXX OCI Registry As Storage

XXX https://stevelasker.blog/2019/05/11/authoring-oci-registry-artifacts-quick-guide/

XXX https://stevelasker.blog/2019/08/08/oci-artifact-authoring-annotations-config-json/

XXX https://github.com/deislabs/oras

```bash
# Start local registry
docker run -d -p 5000:5000 registry:2

# Push multiple files
oras push localhost:5000/buildx:latest hello.c Dockerfile

# Check registry (BROKEN)
curl http://localhost:5000/v2/buildx/tags/list
curl -H "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/buildx/manifests/latest
```

Previous notes:

```bash
oras login registry.dille.io
oras push registry.dille.io/kubeconfig:tst kubeconfig.aes
curl -u "X:Y" -H "Accept: application/vnd.oci.image.manifest.v1+json" https://registry.dille.io/v2/kubeconfig/manifests/tst | jq
# empty config blob
# layers are base64 encoded and encrypted with salted passwort
oras pull registry.dille.io/kubeconfig:tst --output ./output
```