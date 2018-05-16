FROM scratch as builder

ADD media /slides/media
ADD images /slides/images
ADD lib /slides/lib
ADD slides /slides/slides
ADD sponsors /slides/sponsors
ADD slides.html /slides

FROM nginx

COPY --from=builder /var/www/html/* /var/www/html

LABEL maintainer="Nicholas Dille"