FROM alpine:3.19

RUN apk add --update hugo go git

WORKDIR /tmp/hugo

