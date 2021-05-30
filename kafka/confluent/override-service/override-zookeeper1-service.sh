#!/bin/bash

# USER="cp-kafka"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="zookeeper1"
MYID="1"

# PROPERTIES_FILE="/usr/local/confluent/etc/kafka/zookeeper.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/zookeeper1.properties"

# DATA_DIR="/var/lib/zookeeper"
# LOG_DIR="/var/log/kafka"
DATA_DIR="/mnt/zookeeper/data"
LOG_DIR="/mnt/zookeeper/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-zookeeper.service.d
sudo mkdir -p {${DATA_DIR},${LOG_DIR}}
echo ${MYID} | sudo tee ${DATA_DIR}/myid
sudo chown -R confluent:confluent ${DATA_DIR} ${LOG_DIR}

######################################################################

# cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-zookeeper.service
# [Unit]
# Description=Apache Kafka - ZooKeeper
# Documentation=http://docs.confluent.io/
# After=network.target
# 
# [Service]
# Type=simple
# User=cp-kafka
# Group=confluent
# ExecStart=/usr/bin/zookeeper-server-start /etc/kafka/zookeeper.properties
# LimitNOFILE=100000
# TimeoutStopSec=180
# Restart=no
# 
# [Install]
# WantedBy=multi-user.target
# EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-zookeeper.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/zookeeper1-service.env

ExecStart=
ExecStart=/usr/bin/zookeeper-server-start /usr/local/confluent/properties/zookeeper1.properties
EOF

######################################################################

sudo systemctl daemon-reload
