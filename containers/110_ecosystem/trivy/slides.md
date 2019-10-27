## trivy: Image scans in CI/CD

### [trivy](https://github.com/aquasecurity/trivy) made by [Aqua Security](https://www.aquasec.com/)

- Covers OS (alpine, Ubuntu, Debian, CentOS, RedHat)
- Covers package managers (Ruby, Python, PHP, NPM, Rust)

```bash
# Install trivy
curl -sLf https://github.com/aquasecurity/trivy/releases/download/v0.1.6/trivy_0.1.6_Linux-64bit.tar.gz | tar -xvz -C /usr/local/bin trivy

# Break build with high severity findings
trivy \
    --ignore-unfixed \
    --exit-code 1 \
    --severity HIGH,CRITICAL \
    alpine:latest
```

### Cache management

- Databases are cached locally
- Persist across builds
