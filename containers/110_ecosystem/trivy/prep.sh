#!/bin/bash

curl -sLf https://github.com/aquasecurity/trivy/releases/download/v0.1.6/trivy_0.1.6_Linux-64bit.tar.gz | tar -xvz -C /usr/local/bin trivy

# Download databases to avoid delay of X seconds
trivy --download-db-only
