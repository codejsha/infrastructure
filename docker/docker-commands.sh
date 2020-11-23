#!/bin/bash

### build
# https://docs.docker.com/engine/reference/commandline/build/

docker build .
docker build -f Dockerfile.dev .
docker build -t example/apache:2.0 .
docker build -f Dockerfile.dev -t example/apache:2.0 .

######################################################################

### tag and push

docker login registry.example.com
docker tag centos:latest registry.example.com/example/centos:latest
docker push registry.example.com/example/centos:latest

######################################################################

### container

### remove all containers
docker container rm $(docker container ls --all --quiet)
docker container rm $(docker container ls --all --quiet --filter status=exited)
docker rm $(docker container ls --all --quiet)
docker rm $(docker container ls --all --quiet --filter status=exited)

### remove unused containers
docker container prune --force

######################################################################

### image

### remove all images
docker image rm $(docker image ls --all --quiet)
docker rmi $(docker image ls --all --quiet)

### remove dangling images
docker image rm $(docker image ls --all --quiet --filter dangling=true)
docker rmi $(docker image ls --all --quiet --filter dangling=true)

### remove unused images
docker image prune --force

######################################################################

### network

### remove unused networks
docker network prune --force

######################################################################

### volume

### remove unused volumes
docker volume prune --force
