## Build Secrets

Image builds often require secrets

Secrets must not be added:

```Dockerfile
FROM alpine
ADD id_rsa /root/.ssh/
RUN scp user@somewhere:/tmp/data .
RUN rm /root/.ssh/id_rsa
```

Credential disclosure:

- Mistake 1: SSH private key is added to image
- Mistage 2: User and host are disclosed
- Mistake 3: SSH key is removed in another layer