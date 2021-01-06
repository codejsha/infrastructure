#!/bin/bash

COREDNS_VOLUME_DIR="/mnt/volume/coredns"
sudo mkdir -p ${COREDNS_VOLUME_DIR}
sudo /usr/bin/cp -f corefile-server.conf ${COREDNS_VOLUME_DIR}/Corefile

docker container run \
    --detach \
    --name coredns \
    --restart=unless-stopped \
    --publish 53:53/udp \
    --mount type=bind,src=${COREDNS_VOLUME_DIR},dst=/root/coredns \
    coredns/coredns:latest \
    -conf /root/coredns/Corefile
