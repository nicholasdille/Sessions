# goss

## Installation

```bash
curl -fsSL https://goss.rocks/install | sh
```

## Validate container

Start you container using `dgoss` instead of `docker`... same parameters!

```bash
dgoss edit nginx
```

Automatically create tests for a given name:

```bash
goss autoadd nginx
```

Validate container (again... `dgoss` instead of `docker`):

```bash
dgoss run nginx
```

Advantage: No change to image!

## Bake goss in

Run goss container to create it:

```bash
docker run --name goss aelsabbahy/goss goss
```

Mount goss into your container:

```bash
docker run -d --rm --volumes-from goss --name weby nginx
```

Add tests and evaluate definition:

```bash
docker exec weby /goss/goss autoadd nginx
docker cp weby:/goss.yaml .
```

## Health endpoint

Build image and start container:

```bash
docker build --tag nginx-goss .
docker run -d --name nginx nginx-goss
docker exec nginx supervisorctl status
```

Get validation results:

```bash
CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx)
curl http://${CONTAINER_IP}:8080/healthz
```