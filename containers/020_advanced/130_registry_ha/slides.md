## Registry HA

XXX

```bash
# Start registry
docker-compose up -d

# Test registry
curl http://localhost:5000/v2/_catalog
docker pull alpine
docker tag alpine:latest localhost:5000/alpine:latest
docker push localhost:5000/alpine:latest
curl http://localhost:5000/v2/_catalog

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

# Test concurrency
docker pull centos
docker tag centos localhost:32768/centos
cat >test.sh <<EOF
#!/bin/bash
docker push localhost:32768/centos &
docker push localhost:32769/centos &
EOF
bash test.sh
```