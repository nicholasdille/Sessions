## SSH Agent Forwarding

Do not copy secrets into image layers

Buildkit can forward the SSH agent socket

Bad example:

```Dockerfile
FROM ubuntu
COPY id_rsa /root/.ssh/
RUN scp user@somewhere:/tmp/data .
RUN rm /root/.ssh/id_rsa
```

--

## Demo: SSH Agent Forwarding

Buildkit forwards the SSH agent socket

```bash
# Prepare SSH agent
ssh-keygen -f id_rsa_test
eval $(ssh-agent -s)
ssh-add id_rsa_test
ssh-add -l

# Forward into build
export DOCKER_BUILDKIT=1
docker build --ssh default --progress plain .
```
