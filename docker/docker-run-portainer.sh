#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

docker container run \
    --detach \
    --restart unless-stopped \
    --name portainer-server \
    --publish 8000:8000 \
    --publish 9000:9000 \
    --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
    --mount type=bind,src=/mnt/volume/portainer/data,dst=/data \
    portainer/portainer
