# Network Management

How to publish a container port in the bridge network:

```bash
docker run -d -p 80:80 nginx
```

How to publish a container:

```bash
docker run -d --rm --network host nginx
```

## Network context

Containers in the same `docker-compose.yml` are deployed to the same network:

```bash
docker-compose up -d
docker exec -it svc2 sh
ping svc2
```

## Breaking the network context

Containers launched over the mapped daemon socket do not end up in the same network context:

```bash
docker-compose --file docker-compose.yml --file docker-compose.context.yml up -d
docker-compose exec dind sh
```

Inside of the `dind` service, start a new container:

```
docker run -it alpine
```

It will not be able to see any service from the `docker-compose` files:

```
ping svc1
ping svc2
```

##