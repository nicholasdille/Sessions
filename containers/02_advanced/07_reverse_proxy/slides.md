## Reverse Proxy

### Port conflicts

- Caused by multiple services on one host
- For example: Docker registry and frontend

### Reverse Proxy

- Routing of requests to correct container
- Based on `Host` header in HTTP
- Well-known: `nginx`, `haproxy`, `traefik`

### Desired Features

- Manual or automatic wiring
- ACME (Let's Encrypt)