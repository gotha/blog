# Blog 

## Requirements 

Install [hugo](https://gohugo.io/)

## Build

Tested with Hugo version 0.120 and v0.121.2

```sh
hugo
```

### Build with docker

Prepare docker image

```sh
docker build -t local/blog-builder:latest -f Dockerfile.builder .
```

Build the blog:

```sh
docker run -v .:/tmp/hugo local/blog-builder:latest hugo
```

## Local development 

```sh
hugo server
```

## Run inside docker

### Run with docker-compose

```sh
docker-compose up -d
```
