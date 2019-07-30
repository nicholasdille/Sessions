# syntax=docker/dockerfile:experimental

FROM alpine

RUN apk add --no-cache openssh-client
RUN --mount=type=ssh ssh-add -l
CMD cat /keys.txt
