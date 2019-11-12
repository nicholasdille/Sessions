#!/bin/bash

curl -sLf https://github.com/aquasecurity/trivy/releases/download/v0.1.7/trivy_0.1.7_Linux-64bit.tar.gz | tar -xvz -C /usr/local/bin trivy

# Download databases to avoid delay
trivy --refresh
