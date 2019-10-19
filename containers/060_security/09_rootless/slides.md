## Rootless Docker

Reduce attack surface

### It is not...

- Running as non-root in container
- Enabling user namespace mapping

### It is...

- Running `dockerd` as non-root
- Experimental preview in Docker 19.03
- See [slides](https://de.slideshare.net/AkihiroSuda/dockercon-2019-hardening-docker-daemon-with-rootless-mode) by Aikihiro Suda

XXX https://medium.com/@tonistiigi/experimenting-with-rootless-docker-416c9ad8c0d6