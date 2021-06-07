#!/bin/bash

# USER="cp-kafka"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="kafka2"

# PROPERTIES_FILE="/usr/local/confluent/etc/kafka/server.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/kafka2.properties"

# DATA_DIR="/var/lib/kafka"
# LOG_DIR="/var/log/kafka"
DATA_DIR="/mnt/kafka/data"
LOG_DIR="/mnt/kafka/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-server.service.d
sudo mkdir -p {${DATA_DIR},${LOG_DIR}}
sudo chown -R confluent:confluent ${DATA_DIR} ${LOG_DIR}

######################################################################

# cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-server.service
# [Unit]
# Description=Apache Kafka - broker
# Documentation=http://docs.confluent.io/
# After=network.target confluent-zookeeper.target
#
# [Service]
# Type=simple
# User=cp-kafka
# Group=confluent
# ExecStart=/usr/bin/kafka-server-start /etc/kafka/server.properties
# LimitNOFILE=1000000
# TimeoutStopSec=180
# Restart=no
#
# [Install]
# WantedBy=multi-user.target
# EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-server.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/kafka2-service.env

ExecStart=
ExecStart=/usr/bin/kafka-server-start /usr/local/confluent/properties/kafka2.properties
EOF

######################################################################

sudo systemctl daemon-reload
