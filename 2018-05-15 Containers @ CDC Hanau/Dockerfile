FROM scratch as builder

ADD media /slides/media
ADD images /slides/images
ADD slides /slides/slides
ADD sponsors /slides/sponsors
ADD slides.html /slides/index.html

FROM nginx

COPY --from=builder /slides/ /usr/share/nginx/html/

LABEL maintainer="Nicholas Dille"
