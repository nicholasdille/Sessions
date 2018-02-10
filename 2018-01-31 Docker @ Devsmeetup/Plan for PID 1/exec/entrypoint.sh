#!/bin/bash

# `exec` replaces bash in the process tree
exec nginx -g "daemon off;"
