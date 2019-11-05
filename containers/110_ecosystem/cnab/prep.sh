#!/bin/bash

# duffle
curl -sLfo /usr/local/bin/duffle https://github.com/deislabs/duffle/releases/download/0.3.5-beta.1/duffle-linux-amd64
chmod +x /usr/local/bin/duffle

# porter
curl -sLfo /usr/local/bin/porter https://deislabs.blob.core.windows.net/porter/v0.20.2-beta.1/porter-linux-amd64
chmod +x /usr/local/bin/porter
cp /usr/local/bin/porter /usr/local/bin/porter-runtime
for MIXIN in exec kubernetes helm azure terraform az aws gcloud; do
    porter mixin install ${MIXIN} --version latest
done

# cnab-to-oci
git clone https://github.com/docker/cnab-to-oci
cd cnab-to-oci
docker build --tag cnab2oci --target build .
docker create --name cnab2oci cnab2oci
docker cp cnab2oci:/go/src/github.com/docker/cnab-to-oci/bin/cnab-to-oci /usr/local/bin/cnab-to-oci
