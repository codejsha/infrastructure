#!/bin/bash
# set -o errtrace
# set -o errexit
# trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

ZOOKEEPER_VOLUME_DIR="/mnt/volume/zookeeper"
KAFKA_VOLUME_DIR="/mnt/volume/kafka"
KAFKA_LAG_EXPORTER_VOLUME_DIR="/mnt/volume/kafka/kafka-lag-exporter"
PROMETHEUS_VOLUME_DIR="/mnt/volume/prometheus"
GRAFANA_VOLUME_DIR="/mnt/volume/grafana"

sudo rm -rf ${ZOOKEEPER_VOLUME_DIR}
sudo rm -rf ${KAFKA_VOLUME_DIR}
sudo rm -rf ${KAFKA_LAG_EXPORTER_VOLUME_DIR}
sudo rm -rf ${PROMETHEUS_VOLUME_DIR}
sudo rm -rf ${GRAFANA_VOLUME_DIR}

### zookeeper
sudo mkdir -p ${ZOOKEEPER_VOLUME_DIR}/{zookeeper1,zookeeper2,zookeeper3}/{data,datalog,logs}

### kafka
sudo mkdir -p ${KAFKA_VOLUME_DIR}/{kafka1,kafka2,kafka3}/config
sudo chmod -R 777 ${KAFKA_VOLUME_DIR}/{kafka1,kafka2,kafka3}
sudo mkdir -p ${KAFKA_VOLUME_DIR}/jmx_exporter
sudo /bin/cp -f /mnt/share/prometheus/jmx_prometheus_javaagent-0.15.0.jar ${KAFKA_VOLUME_DIR}/jmx_exporter
sudo /bin/cp -f /mnt/share/confluent-platform/jmx-exporter/*.yml ${KAFKA_VOLUME_DIR}/jmx_exporter

### kafka-lag-exporter
sudo mkdir -p ${KAFKA_LAG_EXPORTER_VOLUME_DIR}
sudo /bin/cp -f /mnt/share/confluent-platform/kafka-lag-exporter/* ${KAFKA_LAG_EXPORTER_VOLUME_DIR}
sudo /bin/cp -f ../kafka-lag-exporter/* ${KAFKA_LAG_EXPORTER_VOLUME_DIR}

### prometheus
sudo mkdir -p ${PROMETHEUS_VOLUME_DIR}
sudo /bin/cp -f /mnt/share/confluent-platform/prometheus-config/* ${PROMETHEUS_VOLUME_DIR}
sudo /bin/cp -f prometheus.yml ${PROMETHEUS_VOLUME_DIR}

### grafana
sudo mkdir -p ${GRAFANA_VOLUME_DIR}/provisioning
sudo /bin/cp -rf /mnt/share/confluent-platform/grafana-provisioning/* ${GRAFANA_VOLUME_DIR}/provisioning

### network
KAFKA_DOCKER_NETWORK="stream-network"
docker network create ${KAFKA_DOCKER_NETWORK}

docker-compose up --detach
