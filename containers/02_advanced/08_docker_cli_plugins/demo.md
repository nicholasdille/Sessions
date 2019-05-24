# Demo for Docker CLI Plugins

Place `docker_distribution` in `~/.docker/cli-plugins`

1. Run latest Docker CLI:

    ```
    docker run -d --rm --name docker1903 docker:19.03-rc
    ```

1. Copy `docker-distribution`:

    ```
    curl -sLfO https://gist.github.com/nicholasdille/f5bf74f5b407ce660bd733ab6eb24d9a/raw/adb62a53e0a1e703a822bf4d57e3827686600daf/docker-distribution
    docker cp docker-distribution docker1903:~/.docker/cli-plugins
    ```

1. Enter container and test:

    ```
    docker exec -it docker1093 sh
    docker
    ```