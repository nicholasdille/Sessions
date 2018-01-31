FROM ubuntu:xenial-20180123

RUN apt-get update \
 && apt-get -y install nginx

# Expects the mode to be 0755
ADD entrypoint.sh /

# Mind the difference between shell and exec format
ENTRYPOINT ["/entrypoint.sh"]
