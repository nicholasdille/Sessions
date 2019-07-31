FROM nginx:stable-alpine

RUN apk add --update-cache --no-cache \
        curl \
        git \
        bash

ENV SOURCE
COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh