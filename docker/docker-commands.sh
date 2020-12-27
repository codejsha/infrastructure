######################################################################

### build

docker image build .
docker image build --tag example/tomcat:9 .
docker image build --file Dockerfile.dev --tag example/tomcat:9 .

######################################################################

### tag and push

docker login registry.example.com
docker image tag centos:latest registry.example.com/centos:latest
docker image push registry.example.com/centos:latest

######################################################################

### container

### remove all containers
docker container rm $(docker container ls --all --quiet)

### remove stopped containers
docker container prune --force
docker container rm $(docker container ls --all --quiet --filter status=exited)

######################################################################

### image

### remove all images
docker image rm $(docker image ls --all --quiet)

### remove dangling images
docker image prune --force
docker image rm $(docker image ls --all --quiet --filter dangling=true)

### remove unused images
docker image prune --all --force

######################################################################

### network

### remove unused networks
docker network prune --force

######################################################################

### volume

### remove unused volumes
docker volume prune --force
