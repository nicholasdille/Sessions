## Registry Mirror

XXX

```bash
# Start registry
docker run -d --name registry --env REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io --env REGISTRY_PROXY_USERNAME=nicholasdille --env REGISTRY_PASSWORD='mypass' registry:2

# Start dockerd
docker run -d --privileged --network container:registry --pid container:registry docker:stable-dind --host=tcp://127.0.0.1:2375 --registry-mirror=http://localhost:5000

# Enter pod
docker run -it --env DOCKER_HOST=tcp://127.0.0.1:2375 --network container:registry --pid container:registry docker:stable sh

# Test
apk update && apk add curl
curl http://localhost:5000/v2/_catalog
docker pull alpine
curl http://localhost:5000/v2/_catalog
```