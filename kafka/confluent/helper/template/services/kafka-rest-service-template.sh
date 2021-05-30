#!/bin/bash

# USER="cp-kafka-rest"
# GROUP="confluent"
USER=""
GROUP=""

CONFLUENT_HOME=""
SERVER_NAME=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-rest/kafka-rest.properties"
PROPERTIES_FILE=""

# LOG_DIR="/var/log/confluent/kafka-rest"
LOG_DIR=""

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-rest.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R ${USER}:${GROUP} ${LOG_DIR}

######################################################################

# cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-rest.service
# [Unit]
# Description=A REST proxy for Apache Kafka
# Documentation=http://docs.confluent.io/
# After=network.target confluent-kafka.target
# 
# [Service]
# Type=simple
# User=cp-kafka-rest
# Group=confluent
# Environment="LOG_DIR=/var/log/confluent/kafka-rest"
# ExecStart=/usr/bin/kafka-rest-start /etc/kafka-rest/kafka-rest.properties
# LimitNOFILE=100000
# TimeoutStopSec=180
# Restart=no
# 
# [Install]
# WantedBy=multi-user.target
# EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-rest.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=${USER}
Group=${GROUP}

Environment=
EnvironmentFile=${CONFLUENT_HOME}/services/${SERVER_NAME}-service.env

ExecStart=
ExecStart=/usr/bin/kafka-server-start ${PROPERTIES_FILE}
EOF

######################################################################

sudo systemctl daemon-reload
