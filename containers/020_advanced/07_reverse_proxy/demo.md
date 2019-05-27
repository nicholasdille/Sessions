# Reverse Proxy

Automatic wiring using Traefik:

```bash
docker-compose up -d
IP=$(docker-compose ps -q proxy | xargs docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
```

Instead of publishing ports, you can also use `network_mode: host`.

Testing access to the registry frontend:

```

curl -s --resolve hub.me:80:$IP http://hub.me
```

Testing access to the registry API:

```
curl -s --resolve registry.me:$IP http://registry.me/v2/
```