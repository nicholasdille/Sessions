# Demo: Notary

## Prepare environment

See [sandbox provided by Docker](https://docs.docker.com/engine/security/trust/trust_sandbox/#build-the-sandbox)

```bash
$ docker-compose up –d
$ docker exec –it trustsandbox sh
$ apk update
$ apk add curl
$ docker pull docker/trusttest
$ docker tag docker/trusttest sandboxregistry:5000/test/trusttest:latest
$ curl -sL https://github.com/theupdateframework/notary/releases/download/v0.4.3/notary-Linux-amd64 > notary
$ chmod +x notary
```

# Use Docker Content Trust

```bash
$ export DOCKER_CONTENT_TRUST=1
$ export DOCKER_CONTENT_TRUST_SERVER=https://notaryserver:4443
$ docker pull sandboxregistry:5000/test/trusttest
$ docker push sandboxregistry:5000/test/trusttest:latest
$ docker pull sandboxregistry:5000/test/trusttest
```

# Check data in Notary

```bash
$ ./notary -s https://notaryserver:4443 list sandboxregistry:5000/test/trusttest
$ curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://sandboxregistry:5000/v2/test/trusttest/manifests/latest
$ curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://sandboxregistry:5000/v2/test/trusttest/manifests/latest | wc -c
$ curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://sandboxregistry:5000/v2/test/trusttest/manifests/latest | sha256sum
```

# Verify signature

```bash
$ curl -sLH "Accept: application/vnd.docker.distribution.manifest.v2+json" http://sandboxregistry:5000/v2/tools/manifests/latest | ./notary -s https://notaryserver:4443 verify -q sandboxregistry:5000/tools latest
```