# Demo for image layers

Investigate layers:

```bash
docker build --tag hello-world .
docker history hello-world
```

Example output:

```
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
f5e55821cbaa        4 minutes ago       /bin/sh -c #(nop)  CMD ["java" "HelloWorld"]    0B
22ea0c4a6c4c        4 minutes ago       /bin/sh -c #(nop) COPY file:31c7dcc00f30d559…   426B
823dd2edb8ca        12 days ago         /bin/sh -c /var/lib/dpkg/info/ca-certificate…   355kB
<missing>           12 days ago         /bin/sh -c set -ex;   if [ ! -d /usr/share/m…   309MB
<missing>           12 days ago         /bin/sh -c #(nop)  ENV CA_CERTIFICATES_JAVA_…   0B
<missing>           12 days ago         /bin/sh -c #(nop)  ENV JAVA_DEBIAN_VERSION=8…   0B
<missing>           3 weeks ago         /bin/sh -c #(nop)  ENV JAVA_VERSION=8u181       0B
<missing>           3 weeks ago         /bin/sh -c #(nop)  ENV JAVA_HOME=/docker-jav…   0B
<missing>           3 weeks ago         /bin/sh -c ln -svT "/usr/lib/jvm/java-8-open…   33B
<missing>           3 weeks ago         /bin/sh -c {   echo '#!/bin/sh';   echo 'set…   87B
<missing>           3 weeks ago         /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B
<missing>           3 weeks ago         /bin/sh -c apt-get update && apt-get install…   2.05MB
<missing>           3 weeks ago         /bin/sh -c set -ex;  if ! command -v gpg > /…   7.8MB
<missing>           3 weeks ago         /bin/sh -c apt-get update && apt-get install…   23.2MB
<missing>           3 weeks ago         /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>           3 weeks ago         /bin/sh -c #(nop) ADD file:b3598c18dc395846a…   101MB
```

## Preparation

Upload image to local registry:

```bash
docker run -d -p 5000:5000 registry:2
docker tag hello-world localhost:5000/hello-world
docker push localhost:5000/hello-world
```

## Image Manifests

Download image manifest:

```bash
curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/hello-world/manifests/latest
```

Example output:

```json
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
   "config": {
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 5357,
      "digest": "sha256:f5e55821cbaab45857a4398caff28a0811efdc4970c15229bfc4dfa21a6b546f"
   },
   "layers": [
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 45309934,
         "digest": "sha256:bc9ab73e5b14b9fbd3687a4d8c1f1360533d6ee9ffc3f5ecc6630794b40257b7"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 10740016,
         "digest": "sha256:193a6306c92af328dbd41bbbd3200a2c90802624cccfe5725223324428110d7f"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 4336053,
         "digest": "sha256:e5c3f8c317dc30af45021092a3d76f16ba7aa1ee5f18fec742c84d4960818580"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 852895,
         "digest": "sha256:d21441932c53a4078f379c7c6d299370a6eaee79c862a29db2e25fec39106779"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 249,
         "digest": "sha256:fa76b0d2509232e863931fc1743f1ca2dba3bebdf5f72b4280fae59536303ce7"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 131,
         "digest": "sha256:346fd8610875e8ba7753030b5c197ad56fe76aa4e45d1e70e4b58366e93177c3"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 122121999,
         "digest": "sha256:3ca5d6af9022c9c3b436792a01c58dd29490430d28b04f70385f308e3bdae8a6"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 246728,
         "digest": "sha256:c06cfa2cea32b36c8f5dcc8605166d1f8b72cf02e44163dbf7d14e0379286b55"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 387,
         "digest": "sha256:d4bee8a9f224e12cb4f6cf55a04655b8c36279a1218900d708f24a1443559c40"
      }
   ]
}
```

## Image Configuration

Download image configuration:

```bash
curl -sLH "Accept: application/vnd.docker.container.image.v1+json" http://localhost:5000/v2/hello-world/manifests/latest
```

Example output:

```json
{
   "schemaVersion": 1,
   "name": "hello-world",
   "tag": "latest",
   "architecture": "amd64",
   "fsLayers": [
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:d4bee8a9f224e12cb4f6cf55a04655b8c36279a1218900d708f24a1443559c40"
      },
      {
         "blobSum": "sha256:c06cfa2cea32b36c8f5dcc8605166d1f8b72cf02e44163dbf7d14e0379286b55"
      },
      {
         "blobSum": "sha256:3ca5d6af9022c9c3b436792a01c58dd29490430d28b04f70385f308e3bdae8a6"
      },
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:346fd8610875e8ba7753030b5c197ad56fe76aa4e45d1e70e4b58366e93177c3"
      },
      {
         "blobSum": "sha256:fa76b0d2509232e863931fc1743f1ca2dba3bebdf5f72b4280fae59536303ce7"
      },
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:d21441932c53a4078f379c7c6d299370a6eaee79c862a29db2e25fec39106779"
      },
      {
         "blobSum": "sha256:e5c3f8c317dc30af45021092a3d76f16ba7aa1ee5f18fec742c84d4960818580"
      },
      {
         "blobSum": "sha256:193a6306c92af328dbd41bbbd3200a2c90802624cccfe5725223324428110d7f"
      },
      {
         "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
      },
      {
         "blobSum": "sha256:bc9ab73e5b14b9fbd3687a4d8c1f1360533d6ee9ffc3f5ecc6630794b40257b7"
      }
   ],
   "history": [
      {
         "v1Compatibility": "{\"architecture\":\"amd64\",\"config\":{\"Hostname\":\"\",\"Domainname\":\"\",\"User\":\"\",\"AttachStdin\":false,\"AttachStdout\":false,\"AttachStderr\":false,\"Tty\":false,\"OpenStdin\":false,\"StdinOnce\":false,\"Env\":[\"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\",\"LANG=C.UTF-8\",\"JAVA_HOME=/docker-java-home/jre\",\"JAVA_VERSION=8u181\",\"JAVA_DEBIAN_VERSION=8u181-b13-2~deb9u1\",\"CA_CERTIFICATES_JAVA_VERSION=20170531+nmu1\"],\"Cmd\":[\"java\",\"HelloWorld\"],\"ArgsEscaped\":true,\"Image\":\"sha256:22ea0c4a6c4cc60c1987c7019ec0335ef74b63f3a884567b5bc69f667f6cf127\",\"Volumes\":null,\"WorkingDir\":\"\",\"Entrypoint\":null,\"OnBuild\":[],\"Labels\":null},\"container\":\"c8fdc04cfbe32aac250ff386b2e6bafb9d35d7d2ba6cc356adebbba62afb65b4\",\"container_config\":{\"Hostname\":\"c8fdc04cfbe3\",\"Domainname\":\"\",\"User\":\"\",\"AttachStdin\":false,\"AttachStdout\":false,\"AttachStderr\":false,\"Tty\":false,\"OpenStdin\":false,\"StdinOnce\":false,\"Env\":[\"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\",\"LANG=C.UTF-8\",\"JAVA_HOME=/docker-java-home/jre\",\"JAVA_VERSION=8u181\",\"JAVA_DEBIAN_VERSION=8u181-b13-2~deb9u1\",\"CA_CERTIFICATES_JAVA_VERSION=20170531+nmu1\"],\"Cmd\":[\"/bin/sh\",\"-c\",\"#(nop) \",\"CMD [\\\"java\\\" \\\"HelloWorld\\\"]\"],\"ArgsEscaped\":true,\"Image\":\"sha256:22ea0c4a6c4cc60c1987c7019ec0335ef74b63f3a884567b5bc69f667f6cf127\",\"Volumes\":null,\"WorkingDir\":\"\",\"Entrypoint\":null,\"OnBuild\":[],\"Labels\":{}},\"created\":\"2018-11-11T19:31:04.246564125Z\",\"docker_version\":\"18.09.0\",\"id\":\"a08dce7efa9ff372cc6839a83fbfec287d56223ca679e36a0281fb9edef02c63\",\"os\":\"linux\",\"parent\":\"d52ff5a40ab99f33a539977db5a24609603d81185038f2f7482411513e1d7ccb\",\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"d52ff5a40ab99f33a539977db5a24609603d81185038f2f7482411513e1d7ccb\",\"parent\":\"0e0e65c4d74dc787bdf597970ea76816d6a7ccb35bce2125a59cf2a32ed794d7\",\"created\":\"2018-11-11T19:31:04.093590868Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop) COPY file:31c7dcc00f30d5596dc5eafa8eecfffc14d1b409f397935f2ba5e66259f3f4ec in . \"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"0e0e65c4d74dc787bdf597970ea76816d6a7ccb35bce2125a59cf2a32ed794d7\",\"parent\":\"7eeb19fb378afc40bad5006f3512583f14bced2cd0c8c25b96a833da0e1ff433\",\"created\":\"2018-10-29T23:31:25.812303646Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c /var/lib/dpkg/info/ca-certificates-java.postinst configure\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"7eeb19fb378afc40bad5006f3512583f14bced2cd0c8c25b96a833da0e1ff433\",\"parent\":\"75b5231d4cc9f0b13ea0ee04fa7d010680ea43649363d87b0c6f9d10070b30fb\",\"created\":\"2018-10-29T23:31:22.04316182Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c set -ex; \\t\\tif [ ! -d /usr/share/man/man1 ]; then \\t\\tmkdir -p /usr/share/man/man1; \\tfi; \\t\\tapt-get update; \\tapt-get install -y --no-install-recommends \\t\\topenjdk-8-jre=\\\"$JAVA_DEBIAN_VERSION\\\" \\t\\tca-certificates-java=\\\"$CA_CERTIFICATES_JAVA_VERSION\\\" \\t; \\trm -rf /var/lib/apt/lists/*; \\t\\t[ \\\"$(readlink -f \\\"$JAVA_HOME\\\")\\\" = \\\"$(docker-java-home)\\\" ]; \\t\\tupdate-alternatives --get-selections | awk -v home=\\\"$(readlink -f \\\"$JAVA_HOME\\\")\\\" 'index($3, home) == 1 { $2 = \\\"manual\\\"; print | \\\"update-alternatives --set-selections\\\" }'; \\tupdate-alternatives --query java | grep -q 'Status: manual'\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"75b5231d4cc9f0b13ea0ee04fa7d010680ea43649363d87b0c6f9d10070b30fb\",\"parent\":\"50e2a957fab156abae901f24e99a72391bb45b3520cfa98a1c548bed75a2bb46\",\"created\":\"2018-10-29T23:30:30.163169274Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop)  ENV CA_CERTIFICATES_JAVA_VERSION=20170531+nmu1\"]},\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"50e2a957fab156abae901f24e99a72391bb45b3520cfa98a1c548bed75a2bb46\",\"parent\":\"18e7b695a606fd31fd8727b8fbeae6460336bbce9dfe3c86fcbcccb00e9b91cb\",\"created\":\"2018-10-29T23:30:29.927235067Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop)  ENV JAVA_DEBIAN_VERSION=8u181-b13-2~deb9u1\"]},\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"18e7b695a606fd31fd8727b8fbeae6460336bbce9dfe3c86fcbcccb00e9b91cb\",\"parent\":\"5187977b7f29953599554345b8dad31db61e0689b49dcfecb65bd0acd3f46b3d\",\"created\":\"2018-10-16T05:28:08.350651594Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop)  ENV JAVA_VERSION=8u181\"]},\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"5187977b7f29953599554345b8dad31db61e0689b49dcfecb65bd0acd3f46b3d\",\"parent\":\"248526607d33121bc25111b4cd07bee6252785f23438fc7f9291f15e4e03f55c\",\"created\":\"2018-10-16T05:28:08.150932614Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop)  ENV JAVA_HOME=/docker-java-home/jre\"]},\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"248526607d33121bc25111b4cd07bee6252785f23438fc7f9291f15e4e03f55c\",\"parent\":\"58e8f0f8c2e88f8018f8ad106b7c48f5c20785c8653b9f4a25584f90d9b28d49\",\"created\":\"2018-10-16T05:28:07.959114138Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c ln -svT \\\"/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)\\\" /docker-java-home\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"58e8f0f8c2e88f8018f8ad106b7c48f5c20785c8653b9f4a25584f90d9b28d49\",\"parent\":\"b936c11338eb1ccd19b526628dd647f06e1970329d2ff06b4e88cd7a3dfcf367\",\"created\":\"2018-10-16T05:28:07.28267038Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c { \\t\\techo '#!/bin/sh'; \\t\\techo 'set -e'; \\t\\techo; \\t\\techo 'dirname \\\"$(dirname \\\"$(readlink -f \\\"$(which javac || which java)\\\")\\\")\\\"'; \\t} \\u003e /usr/local/bin/docker-java-home \\t\\u0026\\u0026 chmod +x /usr/local/bin/docker-java-home\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"b936c11338eb1ccd19b526628dd647f06e1970329d2ff06b4e88cd7a3dfcf367\",\"parent\":\"7936b36729d79c0c2c1afe18b7b004ec39ddc232c265b1645ebbfe26516cc347\",\"created\":\"2018-10-16T05:28:06.63208626Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop)  ENV LANG=C.UTF-8\"]},\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"7936b36729d79c0c2c1afe18b7b004ec39ddc232c265b1645ebbfe26516cc347\",\"parent\":\"193e9ec3084b466970ccb698ce9e63d3ea052f9ddc8f1b189e2a70438c3af8cb\",\"created\":\"2018-10-16T05:28:06.412610569Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c apt-get update \\u0026\\u0026 apt-get install -y --no-install-recommends \\t\\tbzip2 \\t\\tunzip \\t\\txz-utils \\t\\u0026\\u0026 rm -rf /var/lib/apt/lists/*\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"193e9ec3084b466970ccb698ce9e63d3ea052f9ddc8f1b189e2a70438c3af8cb\",\"parent\":\"eaf22e48e495214d9e2ad97b95b38070fa5d9d38298ae832ce467b53a3102da1\",\"created\":\"2018-10-16T01:00:57.258682859Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c set -ex; \\tif ! command -v gpg \\u003e /dev/null; then \\t\\tapt-get update; \\t\\tapt-get install -y --no-install-recommends \\t\\t\\tgnupg \\t\\t\\tdirmngr \\t\\t; \\t\\trm -rf /var/lib/apt/lists/*; \\tfi\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"eaf22e48e495214d9e2ad97b95b38070fa5d9d38298ae832ce467b53a3102da1\",\"parent\":\"3d95b2212e1d7c114bf2710150f24cb9c675ac89ae470c80dbcaa05ec8cf8f4e\",\"created\":\"2018-10-16T01:00:49.945915631Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c apt-get update \\u0026\\u0026 apt-get install -y --no-install-recommends \\t\\tca-certificates \\t\\tcurl \\t\\tnetbase \\t\\twget \\t\\u0026\\u0026 rm -rf /var/lib/apt/lists/*\"]}}"
      },
      {
         "v1Compatibility": "{\"id\":\"3d95b2212e1d7c114bf2710150f24cb9c675ac89ae470c80dbcaa05ec8cf8f4e\",\"parent\":\"7503427fa9587960287c89702dd09de660f3add3bdfc3cda81a75e2a44ea815d\",\"created\":\"2018-10-15T23:24:21.111611143Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop)  CMD [\\\"bash\\\"]\"]},\"throwaway\":true}"
      },
      {
         "v1Compatibility": "{\"id\":\"7503427fa9587960287c89702dd09de660f3add3bdfc3cda81a75e2a44ea815d\",\"created\":\"2018-10-15T23:24:20.7838109Z\",\"container_config\":{\"Cmd\":[\"/bin/sh -c #(nop) ADD file:b3598c18dc395846ab2c5e4e8422c4a5dad7bc3b5b08c09ebceee80989904641 in / \"]}}"
      }
   ],
   "signatures": [
      {
         "header": {
            "jwk": {
               "crv": "P-256",
               "kid": "5GHC:V3TC:DUFJ:Q4EG:XBR2:CCPN:7TAX:5MZG:RYVF:6JQF:2GW2:B52A",
               "kty": "EC",
               "x": "HthVX08Ui1_uZDv7imppVEfVj4DpqDugL0ulsA_-kDE",
               "y": "PhjtCnPfxlgRzph7ZWtlIAJSx_Z3giJTk9mG0Emil8I"
            },
            "alg": "ES256"
         },
         "signature": "Td-rINXf58eDjwGmUiivuQHp8XDYXizfRcp2NSqfsNkrQ0QheqXnmT8bXTu-qvMbEMT6oE4eAzqPdyjl4jfQQg",
         "protected": "eyJmb3JtYXRMZW5ndGgiOjEwMjk0LCJmb3JtYXRUYWlsIjoiQ24wIiwidGltZSI6IjIwMTgtMTEtMTFUMTk6Mzc6MjRaIn0"
      }
   ]
}
```

## Download image layer

```bash
curl -sLH "Accept: application/vnd.docker.image.rootfs.diff.tar.gzip" http://localhost:5000/v2/hello-world/blobs/sha256:d4bee8a9f224e12cb4f6cf55a04655b8c36279a1218900d708f24a1443559c40 | tar -tvz
```

## Verifying a layer's digest

```bash
curl -LH "Accept: application/vnd.docker.image.rootfs.diff.tar.gzip" http://localhost:5000/v2/hello-world/blobs/sha256:d4bee8a9f224e12cb4f6cf55a04655b8c36279a1218900d708f24a1443559c40 | sha256sum
```

## Determining the content length

```bash
curl -L http://localhost:5000/v2/hello-world/blobs/sha256:d4bee8a9f224e12cb4f6cf55a04655b8c36279a1218900d708f24a1443559c40 | wc -c
```

## Tagging images remotely

```bash
# Download manifest from old name
MANIFEST=$(curl -u "${REGISTRY_USER}:${REGISTRY_PASS}" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" "${REGISTRY_NAME}/v2/${REPOSITORY}/manifests/${TAG_OLD}")

# Push manifest with new name
curl -u "${REGISTRY_USER}:${REGISTRY_PASS}" -X PUT -H "Content-Type: application/vnd.docker.distribution.manifest.v2+json" -d "${MANIFEST}" "${REGISTRY_NAME}/v2/${REPOSITORY}/manifests/${TAG_NEW}"
```

# Further reading

[Registry API](https://docs.docker.com/registry/spec/api/)
[Image Manifest Specification v2.2](https://docs.docker.com/registry/spec/manifest-v2-2/)