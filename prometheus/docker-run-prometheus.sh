#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

PROMETHEUS_VOLUME_DIR="/mnt/volume/prometheus"
sudo mkdir -p ${PROMETHEUS_VOLUME_DIR}
sudo /bin/cp -f prometheus.yaml ${PROMETHEUS_VOLUME_DIR}/prometheus.yml

######################################################################

function docker_run_prometheus {
    docker container run \
        --detach \
        --name prometheus \
        --publish 9090:9090 \
        --mount type="bind",src="${PROMETHEUS_VOLUME_DIR}",dst="/etc/prometheus" \
        prom/prometheus
}

######################################################################

docker_run_prometheus
