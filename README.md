# Blog 

## Requirements 

Install [hugo](https://gohugo.io/)

## Build

```sh
hugo
```

### Build with docker

Prepare docker image

```sh
docker build -t local/blog:latest -f Dockerfile.builder .
```

Build the blog:

```sh
docker run -v .:/tmp/hugo local/blog:latest hugo
```

## Local development 

```sh
hugo server
```
