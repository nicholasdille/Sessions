## Reverse Proxy

### Why? Port conflicts!

- Caused by multiple services on one host
- For example: Multiple stages of the same environment
- For example: Multiple web-based services using the same port

### Reverse Proxy

- Routing of requests to correct container
- Based on `Host` header in HTTP
- Well-known: `nginx`, `haproxy`, `traefik`

### Desired Features

- HTTP(S)
- Automatic wiring
- Automatic certificates

--

## Reverse Proxy

HTTP: Routing based on `Host` header

HTTPS: Routing based on Server Name Indication (SNI)

![](020_advanced/070_reverse_proxy/reverse-proxy.svg) <!-- .element: class="center-image" -->

XXX maybe use multiple networks (frontend / backend)

--

## Demo: Reverse Proxy

Automatic wiring using Traefik:

```bash
docker-compose up -d
IP=$(
  docker-compose ps -q proxy \
  | xargs docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
)
```

Instead of publishing ports, you can also use `network_mode: host`.

Testing access to the registry frontend:

```bash
curl -s --resolve hub.me:80:$IP http://hub.me
```

Testing access to the registry API:

```bash
curl -s --resolve registry.me:$IP http://registry.me/v2/
```

XXX traefik v2