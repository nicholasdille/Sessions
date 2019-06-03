## Multi Stage Builds - Concurrency

### Features

- Stages can be built in parallel

```Dockerfile
FROM alpine as build1
RUN touch /opt/binary1

FROM alpine as build2
RUN touch /opt/binary2

FROM alpine
COPY --from=build1 /opt/binary1 /opt/
COPY --from=build2 /opt/binary2 /opt/
```

### Support

- Added in Docker 17.09
- Based on BuildKit