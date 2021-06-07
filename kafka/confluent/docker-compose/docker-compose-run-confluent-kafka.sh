#!/bin/bash
# set -o errtrace
# set -o errexit
# trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

KAFKA_VOLUME_DIR="/mnt/volume/confluent"
ZOOKEEPER_VOLUME_DIR="${KAFKA_VOLUME_DIR}"
PROMETHEUS_VOLUME_DIR="${KAFKA_VOLUME_DIR}/prometheus"
GRAFANA_VOLUME_DIR="${KAFKA_VOLUME_DIR}/grafana"
JMX_EXPORTER_VOLUME_DIR="${KAFKA_VOLUME_DIR}/jmx_exporter"
KAFKA_LAG_EXPORTER_VOLUME_DIR="${KAFKA_VOLUME_DIR}/kafka-lag-exporter"

sudo rm -rf ${KAFKA_VOLUME_DIR}

### prometheus
sudo mkdir -p ${PROMETHEUS_VOLUME_DIR}
sudo /bin/cp -f prometheus.yml alert.rules ${PROMETHEUS_VOLUME_DIR}

### grafana
sudo mkdir -p ${GRAFANA_VOLUME_DIR}/provisioning
sudo /bin/cp -rf /mnt/share/confluent-platform/grafana/{dashboards,datasources} ${GRAFANA_VOLUME_DIR}/provisioning

### jmx-exporter
sudo mkdir -p ${JMX_EXPORTER_VOLUME_DIR}
sudo /bin/cp -f /mnt/share/prometheus/jmx_prometheus_javaagent-0.15.0.jar ${KAFKA_VOLUME_DIR}/jmx_exporter
sudo /bin/cp -f /mnt/share/confluent-platform/jmx-exporter/*.yml ${KAFKA_VOLUME_DIR}/jmx_exporter

### kafka-lag-exporter
sudo mkdir -p ${KAFKA_LAG_EXPORTER_VOLUME_DIR}
sudo /bin/cp -f application.conf logback.xml ${KAFKA_LAG_EXPORTER_VOLUME_DIR}

### network
KAFKA_DOCKER_NETWORK="stream-network"
docker network create ${KAFKA_DOCKER_NETWORK}

docker-compose up --detach
