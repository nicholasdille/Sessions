# Reverse Proxy

Automatic wiring using Traefik:

```bash
docker-compose up -d
```

Instead of publishing ports, you can also use `network_mode: host`.

Testing access to the registry frontend:

```
IP=$(docker-compose ps -q web | xargs docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{.end}}')
curl -v --resolve hub.me:80:$IP http://hub.me
```

Testing access to the registry API:

```
IP=$(docker-compose ps -q registry | xargs docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{.end}}')
curl -v --resolve registry.me:80:$IP http://registry.me
```