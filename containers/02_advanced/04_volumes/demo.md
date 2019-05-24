# Demo

1. Bind mount using old syntax

  ```
  docker run --volume $(pwd):/src ...
  ```

  Local directory will be created silently

1. Bind mount using new syntax

  ```
  docker run --mount type=bind,source=$(pwd),target=/src ...
  ```

  Failes of local directory does not exist

1. Volume mount

  ```
  docker volume create myvol
  docker volume ls
  docker volume inspect myvol
  docker -it --rm --volume myvol:/src ubuntu
  ```

1. Access permissions:

  ```bash
  docker -it --rm --volume myvol:/src:ro ubuntu
  ```

1. Real temporary data:

  ```bash
  docker -it --rm --tmpfs /src ubuntu
  ```

See also [sshfs](https://github.com/vieux/docker-volume-sshfs).