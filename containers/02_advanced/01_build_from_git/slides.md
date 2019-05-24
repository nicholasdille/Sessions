## Build from git

### Build context

- Location with files
- `docker build <directory>`
- Must contain Dockerfile
- Directory content is sent to daemon
- Exclusions defined in `.dockerignore`

### Remote context

- Format: `<url>#<branch>:<directory>`
- Supported by `docker build`
- Supported by `docker-compose`