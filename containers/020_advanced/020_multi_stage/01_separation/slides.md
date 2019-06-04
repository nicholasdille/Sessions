## Multi Stage Builds - Separation

### Features

- Build and runtime environment
- Multiple `FROM` sections
- Last section represents final image

```Dockerfile
FROM openjdk:8-jdk as builder
#...

FROM openjdk:8-jre
COPY --from=builder ...
#...
```

### Support

- Added in Docker 17.09
- Based on BuildKit

--

## Demo: Multi Stage Builds - Separation

```
docker build --tag hello-world-java:multi .
```