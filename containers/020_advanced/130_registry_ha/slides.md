## Registry HA

Docker registry is able to use shared storage

XXX S3

### Start

XXX volume for service

```bash
# Start registry
docker-compose up -d
```

--

## Registry HA: Basic testing

XXX

```bash
# Test registry
curl http://localhost:5000/v2/_catalog
docker pull alpine
docker tag alpine:latest localhost:5000/alpine:latest
docker push localhost:5000/alpine:latest
curl http://localhost:5000/v2/_catalog
```

--

## Registry HA: Scale-out

XXX random ports

```bash
# Scale registry
docker-compose up -d --scale registry=2

# Test registry nodes
curl http://localhost:32768/v2/_catalog
curl http://localhost:32769/v2/_catalog
docker pull ubuntu
docker tag ubuntu localhost:32768/ubuntu
docker push localhost:32768/ubuntu
curl http://localhost:32768/v2/_catalog
curl http://localhost:32769/v2/_catalog
```

--

## Registry HA: Concurrency

XXX

```bash
docker pull centos
docker tag centos localhost:32768/centos

# Upload to both registries at the same tme
cat >test.sh <<EOF
#!/bin/bash
docker push localhost:32768/centos &
docker push localhost:32769/centos &
EOF
bash test.sh

# Check contents
curl http://localhost:32768/v2/_catalog
curl http://localhost:32769/v2/_catalog
```
