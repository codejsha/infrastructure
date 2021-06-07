#!/bin/bash

# USER="cp-ksql"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="ksqldb1"

# PROPERTIES_FILE="/usr/local/confluent/etc/ksqldb/ksql-server.properties"
# PROPERTIES_FILE="/usr/local/confluent/etc/ksqldb/ksql-production-server.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/ksqldb1.properties"

# DATA_DIR="/var/lib/kafka-streams"
# LOG_DIR="/var/log/confluent/ksql"
DATA_DIR="/mnt/ksqldb/data"
LOG_DIR="/mnt/ksqldb/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-ksqldb.service.d
sudo mkdir -p {${DATA_DIR},${LOG_DIR}}
sudo chown -R confluent:confluent ${DATA_DIR} ${LOG_DIR}

######################################################################

# cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-ksqldb.service
# [Unit]
# Description=Streaming SQL engine for Apache Kafka
# Documentation=http://docs.confluent.io/
# After=network.target confluent-kafka.target confluent-schema-registry.target
#
# [Service]
# Type=simple
# User=cp-ksql
# Group=confluent
# Environment="LOG_DIR=/var/log/confluent/ksql"
# ExecStart=/usr/bin/ksql-server-start /etc/ksqldb/ksql-server.properties
# TimeoutStopSec=180
# Restart=no
#
# [Install]
# WantedBy=multi-user.target
# EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-ksqldb.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/ksqldb1-service.env

ExecStart=
ExecStart=/usr/bin/ksql-server-start /usr/local/confluent/properties/ksqldb1.properties
EOF

######################################################################

sudo systemctl daemon-reload
