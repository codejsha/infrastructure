#!/bin/bash

# USER="cp-kafka-connect"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="kafka-connect2"

# PROPERTIES_FILE="/usr/local/confluent/etc/kafka/connect-standalone.properties"
# PROPERTIES_FILE="/usr/local/confluent/etc/kafka/connect-distributed.properties"
# PROPERTIES_FILE="/usr/local/confluent/etc/schema-registry/connect-avro-standalone.properties"
# PROPERTIES_FILE="/usr/local/confluent/etc/schema-registry/connect-avro-distributed.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/kafka-connect2.properties"

# LOG_DIR="/var/log/kafka"
LOG_DIR="/mnt/kafka-connect/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-connect.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R confluent:confluent ${LOG_DIR}

######################################################################

# cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-connect.service
# [Unit]
# Description=Apache Kafka Connect - distributed
# Documentation=http://docs.confluent.io/
# After=network.target confluent-server.target
# 
# [Service]
# Type=simple
# User=cp-kafka-connect
# Group=confluent
# ExecStart=/usr/bin/connect-distributed /etc/kafka/connect-distributed.properties
# TimeoutStopSec=180
# Restart=no
# 
# [Install]
# WantedBy=multi-user.target
# EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-connect.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/kafka-connect2-service.env

ExecStart=
ExecStart=/usr/bin/connect-distributed /usr/local/confluent/properties/kafka-connect2.properties
EOF

######################################################################

sudo systemctl daemon-reload
