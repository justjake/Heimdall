# This dockerfile is for the development of Heimdall.
# It is not related to the Linuxserver.io docker image.
# See https://github.com/linuxserver/docker-heimdall for distribution packaging

FROM alpine:3.10.3

# Install system packages
RUN apk add --update --no-cache \
  curl \
  php7 \
	php7-ctype \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-tokenizer \
  php7-phar \
	php7-zip \
	php7-fileinfo \
	php7-dom \
	php7-xml \
	php7-xmlwriter \
  php7-session \
  composer

WORKDIR /app
