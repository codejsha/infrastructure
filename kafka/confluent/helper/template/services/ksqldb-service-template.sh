#!/bin/bash

# USER="cp-ksql"
# GROUP="confluent"
USER=""
GROUP=""

CONFLUENT_HOME=""
SERVER_NAME=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/ksqldb/ksql-server.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/ksqldb/ksql-production-server.properties"
PROPERTIES_FILE=""

# DATA_DIR="/var/lib/kafka-streams"
# LOG_DIR="/var/log/confluent/ksql"
DATA_DIR=""
LOG_DIR=""

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-ksqldb.service.d
sudo mkdir -p {${DATA_DIR},${LOG_DIR}}
sudo chown -R ${USER}:${GROUP} ${DATA_DIR} ${LOG_DIR}

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
User=${USER}
Group=${GROUP}

Environment=
EnvironmentFile=${CONFLUENT_HOME}/services/${SERVER_NAME}-service.env

ExecStart=
ExecStart=/usr/bin/ksql-server-start ${PROPERTIES_FILE}
EOF

######################################################################

sudo systemctl daemon-reload
