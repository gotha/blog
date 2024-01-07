---
title: "How Docker Swarm made me realize that I am doing secrets wrong"
date: "2021-09-25"
categories: 
  - "misc"
  - "oss"
---

The first thing most people do in a new project is to create `config` file and then immediately put it in `.gitignore`.  
Of course, you do not want to have potentially sensitive data under revision control.  
Another place where we do not want secrets is in our Docker images. Don't forget to add it to `.dockerignore`, I've made that mistake.

So there is a conflict, we instinctively want to read from files (because it is easy), but we do not want that file to end in the wrong place.

"Well, the solution is simple, just use environment variables" - you'll probably say and you'll be right. After all that's what the [the 12 factor app](https://12factor.net/config) told us to do.  
As a compromise we usually setup our apps to load configuration and secrets from env variables and we load the env variables from `.env` file - good compromise.

Even in k8s environment we were used to "map" Kubernetes secrets to environment variables of the pod.  
Docker Compose also embraces this approach to the point that if you want you can directly reference values from `.env` in `docker-compose.yaml`.

So imagine my surprise when I realized that Docker Swarm does not support this feature. Even more, [the docs](https://docs.docker.com/engine/swarm/secrets/) say that they intentionally chose not to do it.  
At first I was trying to fight this decision, I went through denial, anger, bargaining, etc. but then it hit me, it is actually a brilliantly simple solution for a hard problem.

What Docker Swarm is doing to store your secret encrypted and when the container starts, Swarm will mount it as a file under `/run/secrets` and then you can read it.  
First of all is super simple and more importantly, if you change the database password you don't have to go and update the env vars on each container, you just change the secret and you are set.

Of course you can use tools like Hashicorp Vault or AWS SecretsManager to read secrets when you app starts, but this is significantly more complicated than reading a file.

Some problems coming from storing secrets in env variables:

- they are literally `variables`, they are mutable, anybody can change the value
- sometimes when when setting them some data gets mangled and people tend to base64 everything to make sure it is all safe
- it is tricky to deal with formatting, new lines, etc. (if you want to have YAML or JSON for some reason)
- env variables "leak" to child processes
- env variables have the tendency to show up in logs

The main problem with reading from a file:  
As a lot of docker related this, this is also half baked. Reading from a file while developing locally is easy. The same code can be used in production in Swarm mode, but what if you decide to test your code locally with `docker-compose` ? Well you are f-ed! Even though that the docs state otherwise, secrets do not work with `docker-compose` and you are stuck with env variables.  
You have already added the secrets file in `.dockerignore` so there is no way to add it in the container image.  
So … either "temporarily" remove it from '.dockerignore' and pray that you won't forget to add it again (and you won't push the image to docker registry) or … make you app load secrets from both file and env variables, at which point I hope you are like "wtf dude !"

Docker insists on their solution and do not plan on ever supporting what the people really want.  
You can "hack" the system by keep reading from environment and set your Dockerfile's entry point to be a script that reads from file and set environment variables, but it is a bit ugly, and if you want to switch to another orchestrator you have to modify your Docker files and rebuild images.

Thank you Docker. I learned a lot and I really believe your solution is superior to what we do right now, but for now … sadly I'll keep using env variables for now.

A [comment](https://github.com/docker/compose/issues/4865#issuecomment-832902825) on the [github issue](https://github.com/docker/compose/issues/4865) sums this up pretty well:

```
I've also hit this issue with docker 20.03 using docker service update service-add .
There is no /run/secrets directory in the container.
Did not try the tmpfs workaround.
Seeing this ticket closed without a fix or a solution makes me lose more confidence in docker.
```
