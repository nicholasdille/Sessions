# Demo for building from git

Using `docker build`:

```
docker build --tag hello-world-java:git github.com/nicholasdille/Sessions#master:containers/02_advanced/01_build_from_git
docker run hello-world-java:git
```

Using `docker-compose`:

```
docker-compose up
```