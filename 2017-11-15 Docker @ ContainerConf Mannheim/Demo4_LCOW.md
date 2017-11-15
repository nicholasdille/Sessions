# Demo: LCOW

**Note: Current (as of 2017-11-14) build of Docker EE for Windows crash when starting Windows containers.**

## Prepare Environment

Prerequisites:

- VM with Windows (Server) 1709
- Add feature containers and Hyper-V
- Create VM
- Enable nested virtualization

[Detailed description for setting up LCOW](https://www.thomasmaurer.ch/2017/10/how-to-run-docker-linux-container-on-windows-server-1709/) by [Thomas Maurer](https://twitter.com/thomasmaurer) - prefer this in favour of the [outdated description for setting up LCOW](https://blog.docker.com/2017/09/preview-linux-containers-on-windows/)

Download location for [Docker EE Stable](https://docs.docker.com/engine/installation/windows/docker-ee/)

## Install and configure Docker

```powershell
Install-Module DockerProvider
Install-Package Docker -ProviderName DockerProvider -RequiredVersion preview
[Environment]::SetEnvironmentVariable("LCOW_SUPPORTED", "1", "Machine")
Restart-Service Docker
```

## Run Linux container

```powershell
docker run -it ubuntu
```