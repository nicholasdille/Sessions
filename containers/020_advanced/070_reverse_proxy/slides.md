## Reverse Proxy

### Port conflicts

- Caused by multiple services on one host
- For example: Multiple stages of the same environment
- For example: Multiple web-based services using the same port

### Reverse Proxy

- Routing of requests to correct container
- Based on `Host` header in HTTP
- Well-known: `nginx`, `haproxy`, `traefik`

### Desired Features

- Automatic wiring
- Automatic certificates

---

## Reverse Proxy

XXX