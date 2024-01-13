FROM alpine:3.19 AS builder

RUN apk add --update hugo go git

WORKDIR /tmp/hugo

COPY . .

RUN hugo 

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html

COPY --from=builder /tmp/hugo/public .

EXPOSE 80/tcp
