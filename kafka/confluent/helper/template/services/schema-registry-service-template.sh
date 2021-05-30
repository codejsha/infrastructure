#!/bin/bash

# USER="cp-schema-registry"
# GROUP="confluent"
USER=""
GROUP=""

CONFLUENT_HOME=""
SERVER_NAME=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/schema-registry/schema-registry.properties"
PROPERTIES_FILE=""

# LOG_DIR="/var/log/confluent/schema-registry"
LOG_DIR=""

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-schema-registry.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R ${USER}:${GROUP} ${LOG_DIR}

######################################################################

# cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-schema-registry.service
# [Unit]
# Description=RESTful Avro schema registry for Apache Kafka
# Documentation=http://docs.confluent.io/
# After=network.target confluent-kafka.target
# 
# [Service]
# Type=simple
# User=cp-schema-registry
# Group=confluent
# Environment="LOG_DIR=/var/log/confluent/schema-registry"
# ExecStart=/usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties
# TimeoutStopSec=180
# Restart=no
# 
# [Install]
# WantedBy=multi-user.target
# EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-schema-registry.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=${USER}
Group=${GROUP}

Environment=
EnvironmentFile=${CONFLUENT_HOME}/services/${SERVER_NAME}-service.env

ExecStart=
ExecStart=/usr/bin/schema-registry-start ${PROPERTIES_FILE}
EOF

######################################################################

sudo systemctl daemon-reload
