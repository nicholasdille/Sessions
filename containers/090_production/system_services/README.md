# Containerizing System Services

System service can be containerized by adding the required capabilities:

```bash
docker build --tag ntpd .
docker-compose up -d
```