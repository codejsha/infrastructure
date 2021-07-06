#!/bin/bash

# USER="cp-kafka-connect"
# GROUP="confluent"
USER="confluent"
GROUP="confluent"

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="replicator1"

# PROPERTIES_FILE="/usr/local/confluent/etc/kafka-connect-replicator/replicator.properties"
# PROPERTIES_FILE="/usr/local/confluent/etc/kafka-connect-replicator/replicator-connect-standalone.properties"
# PROPERTIES_FILE="/usr/local/confluent/etc/kafka-connect-replicator/replicator-connect-distributed.properties"
PROPERTIES_FILE="/usr/local/confluent/properties/replicator1.properties"

# LOG_DIR="/var/log/kafka"
LOG_DIR="/mnt/replicator/logs"

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-replicator.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R confluent:confluent ${LOG_DIR}

######################################################################

### default (custom)

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-replicator.service
[Unit]
Description=Confluent Replicator
Documentation=http://docs.confluent.io/
After=network.target confluent-server.target

[Service]
Type=simple
User=cp-kafka-connect
Group=confluent
ExecStart=/usr/bin/connect-distributed /etc/kafka-connect-replicator/replicator-connect-distributed.properties
TimeoutStopSec=180
Restart=no

[Install]
WantedBy=multi-user.target
EOF

######################################################################

### override

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-replicator.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=confluent
Group=confluent

Environment=
EnvironmentFile=/usr/local/confluent/services/replicator1-service.env

ExecStart=
ExecStart=/usr/bin/connect-distributed /usr/local/confluent/properties/replicator1.properties
EOF

######################################################################

sudo systemctl daemon-reload
