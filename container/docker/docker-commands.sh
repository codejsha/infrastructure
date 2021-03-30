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

### save
docker save --output ${IMAGE_FILE} ${IMAGE}:${TAG}

### load
docker load --input ${IMAGE_FILE}

######################################################################

### network

### create network
docker network create stream-network

### connect container to network
docker network connect stream-network kafka

### disconnect container from network
docker network disconnect stream-network kafka

### remove unused networks
docker network prune --force

######################################################################

### volume

### remove unused volumes
docker volume prune --force

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

docker login core.harbor.example.com
docker image tag centos:latest core.harbor.example.com/library/centos:latest
docker image push core.harbor.example.com/library/centos:latest

######################################################################

### registry

### repo list
curl --insecure --request GET --user ${USER}:${PASSWORD} https://registry.example.com/v2/_catalog

### image list
curl --request GET --user ${USER}:${PASSWORD} http://registry.example.com/v2/${IMAGE_NAME}/tags/list
