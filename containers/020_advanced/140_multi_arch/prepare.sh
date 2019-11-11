#!/bin/bash

# Add local registry
docker run -d --volume $(pwd)/registry:/var/lib/registry --net container:buildx_buildkit_mybuilder0 registry:2
docker run -d --volume $(pwd)/registry:/var/lib/registry -p 127.0.0.1:5000:5000 registry:2