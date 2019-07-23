## Pitfalls of using `latest`

### YNKWYGG

You Never Know What You‘re Gonna Get

### Outdated image

New containers are started based on existing images  Pull policy

### Multiple services using different latest

Same image but rolled out at different times

Reschedule will break at least one of them

--

## Automatic housekeeping

## Handling containers required testing

Run containers to test something

Run tools distributed in containers

Many exited containers remain behind

### Temporary containers can be removed automatically

```
docker run --rm ...
```

--

## Housekeeping

### Cleanup before build

Create sane environment to work with

### Cleanup after build

Save space

### Commands

```
docker ps -aq | xargs -r docker rm -f
docker images -q | xargs -r docker rmi -f
```

--

## Custom formats

### Default output is very wide

Output of most Docker commands creates line breaks

### Define condensed output

Most Docker commands allow custom formats using --format

XXX

--

## File permissions on volumes

### Problem statement

Use containerized tool with bind mount (mapped local directory)

Creating files on volumes get owner from container

Often creates root-owned files and directories

Those cannot be removed by user

### Solution

Launch container with different user

May break container!