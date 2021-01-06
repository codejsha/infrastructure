#!/bin/bash

PROMETHEUS_VOLUME_DIR="/mnt/volume/prometheus"
sudo mkdir -p ${PROMETHEUS_VOLUME_DIR}
sudo /usr/bin/cp -f prometheus.yaml ${PROMETHEUS_VOLUME_DIR}/prometheus.yml

docker container run \
    --detach \
    --name prometheus \
    --publish 9090:9090 \
    --mount type=bind,src=${PROMETHEUS_VOLUME_DIR},dst=/etc/prometheus \
    prom/prometheus
