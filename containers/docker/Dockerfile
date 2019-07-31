FROM nginx:stable-alpine

RUN apk add --update-cache --no-cache \
        curl \
        git \
        bash

ENV SOURCE
ENV ROOT
COPY default.conf /etc/nginx/conf.d/
COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh