#!/bin/bash

# USER="cp-kafka-rest"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="kafka-rest2"

# PROPERTIES_FILE="/usr/local/confluent/etc/kafka-rest/kafka-rest.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/kafka-rest2.properties"

# LOG_DIR="/var/log/confluent/kafka-rest"
LOG_DIR="/mnt/kafka-rest/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-rest.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R confluent:confluent ${LOG_DIR}

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
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/kafka-rest2-service.env

ExecStart=
ExecStart=/usr/bin/kafka-server-start /usr/local/confluent/properties/kafka-rest2.properties
EOF

######################################################################

sudo systemctl daemon-reload
