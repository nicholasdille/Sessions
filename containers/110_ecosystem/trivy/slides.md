## trivy: Image scans in CI/CD

### [trivy](https://github.com/aquasecurity/trivy) made by [Aqua Security](https://www.aquasec.com/)

- Covers OS (alpine, Ubuntu, Debian, CentOS, RedHat)
- Covers package managers (Ruby, Python, PHP, NPM, Rust)

```bash
# Break build with high severity findings
trivy \
    --ignore-unfixed \
    --exit-code 1 \
    --severity HIGH,CRITICAL \
    alpine:latest
```

### Cache management

- Databases are cached locally
- Persist across builds (e.g. host-local cache with `--skip-update` and `--cache-dir`)
