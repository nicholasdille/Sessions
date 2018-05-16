## LCOW

*Linux Containers On Windows*

One service to rule them allow

- Windows containers
- Linux containers in Hyper-V

Same behaviour as hybrid swarm

**Prerequisites:** Docker for Windows 18.03 (Edge Channel) <!-- .element: style="color: #ff8800;" -->

--

## DEMO

<video id="hovercontrols">
    <source data-src="videos/LCOW.mp4" type="video/mp4" />
</video>

--

## Code

docker-compose.yml:

```yaml
version: '3.2'
services:
    weblin:
        image: nginx
    webwin:
        image: microsoft/iis:windowsservercore-1709
```

Commands:

```
docker-compose up -d
docker-compose ps
```
