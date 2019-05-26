# Demo

1. Bind mount using old syntax

  ```
  docker run -it --rm --volume $(pwd):/src alpine
  ```

  Local directory will be created silently:

  ```
  docker run -it --rm --volume $(pwd)/missing:/src alpine
  ```

1. Bind mount using new syntax

  ```
  docker run -it --rm --mount type=bind,source=$(pwd),target=/src alpine
  ```

  Fails of local directory does not exist:

  ```
  docker run -it --rm --mount type=bind,source=$(pwd)/missing,target=/src alpine
  ```

1. Volume mount

  ```
  docker volume create myvol
  docker volume ls
  docker volume inspect myvol
  docker -it --rm --volume myvol:/src alpine
  ```

1. Access permissions:

  ```
  docker -it --rm --volume myvol:/src:ro alpine
  ```

  Works for bind mounts as well

1. Real temporary data:

  ```
  docker run -it --rm --tmpfs /src alpine
  ```

See also [sshfs](https://github.com/vieux/docker-volume-sshfs).