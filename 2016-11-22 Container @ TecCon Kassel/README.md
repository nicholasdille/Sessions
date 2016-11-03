# Introduction

This directory contains the files used in my sessions about Windows Containers at [TecCon in Kassel](https://www.dcug.de/events/teccon2016/).

# Content

- Talk
- Workshop

Both session will use the web content located in the subdirectory called `www`.

# Best Practices

- Plan for cleanup: docker run -d --rm --name iis nicholasdille/iis
- Cleanup manually: docker ps -qf "status=exited" | % {docker rm $_}
- Use volumes for data
- Use new image for binaries
- Change prompt in container
- Mounting volume will only work for empty directories inside container (https://github.com/docker/docker/issues/20127)
