FROM docker:19.03-rc

WORKDIR /root/.docker/cli-plugins
COPY docker-distribution docker-distribution
RUN apk add --update-cache --no-cache bash curl jq \
 && chmod +x *