## Tagging strategies

### Tags are aliases for image versions

### `Latest` has no universal meaning

### Individual version / build number

### Meaningful named tags

stable for tested images

dev or vnext for untested images

master for builds of master branch

### More tags = choice

Latest v1.1.x should also be tagged as v1.1, v1 and stable

Latest v1.1.x-alpine should also be tagged as stable-alpine

Latest build of `master` branch should be tagged master

--

## One process per container

### The optimist

Separating functionality

Enabling scalability

### The realist

Multiple processes in a container may make sense

Depends on server

--

## Build versus Runtime

### Build parameters

Versions of tools to be installed

Features to enable

Use build arguments

Define with ARG statement in Dockerfile

Supply on build: docker build --build-arg <name>=<value>

### Runtime parameters

Configure behaviour

Use environment variables (ENV statement in Dockerfile)

See Tweaking runtime behaviour

--

## Using proxy servers

### Do not hardcore in Dockerfile

### During build

docker run --build-arg http_proxy --build-arg https_proxy .

### During runtime

docker run --env http_proxy --env https_proxy ubuntu

###Docker daemon

Honours environment variables http_proxy, https_proxy and no_proxy

--

## Tweaking runtime behaviour

## ENV

Do not hardcode values into commands

Use environment variables

Set reasonable defaults

### CMD and ENTRYPOINT

Changes behaviour on start

### Shell and exec notation

Determines whether a command is wrapped by a new shell

--

## Version pinning versus latest

### Downsides of using latest

Breaks reproducibility

Causes conflict with two services based on the same image

Version pinning in Dockerfile

Hard/impossible to determine running image version (see microlabeling)

### Upsides of using latest

No need for version pinning

Always receive updates

### Strong downs but weak ups

--

## Do not use latest

XXX

--

## Derive from code

### Using community images is like buying a pig in a poke

Community images may not receive updates

Community images may follow undesirable paths

Community images may introduce security issues

Community images may not be updated at all

### Solution

Fork code repository and build yourself