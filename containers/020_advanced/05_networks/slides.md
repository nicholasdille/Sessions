## Network Management

### bridge (default)

- Private IP addresses
- SNAT for egress
- Port publishing for ingress

### host

- No network isolation

### none

- No network

### overlay

- Span multiple hosts (e.g. Docker Swarm)

---

## Network Context

### Default

- Used by `docker run`
- Containers are on their own

### Custom

- Used by `docker run --net ...`
- Service discovery using DNS
- Used by `docker-compose`

### Common Issue

- Map Docker socket in `docker-compose.yml`
- Containers created through socket are in the default network
- They are unreachable from services defined in `docker-compose.yml`