#!/bin/bash

# USER="cp-schema-registry"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="schema-registry2"

# PROPERTIES_FILE="/usr/local/confluent/etc/schema-registry/schema-registry.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/schema-registry2.properties"

# LOG_DIR="/var/log/confluent/schema-registry"
LOG_DIR="/mnt/schema-registry/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-schema-registry.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R confluent:confluent ${LOG_DIR}

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
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/schema-registry2-service.env

ExecStart=
ExecStart=/usr/bin/schema-registry-start /usr/local/confluent/properties/schema-registry2.properties
EOF

######################################################################

sudo systemctl daemon-reload
