#!/bin/bash

# USER="cp-kafka-connect"
# GROUP="confluent"
USER=""
GROUP=""

CONFLUENT_HOME=""
SERVER_NAME=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-connect-replicator/replicator.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-connect-replicator/replicator-connect-standalone.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-connect-replicator/replicator-connect-distributed.properties"
PROPERTIES_FILE=""

# LOG_DIR="/var/log/kafka"
LOG_DIR=""

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-replicator.service.d
sudo mkdir -p ${LOG_DIR}
sudo chown -R ${USER}:${GROUP} ${LOG_DIR}

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-replicator.service
[Unit]
Description=Confluent Replicator
Documentation=http://docs.confluent.io/
After=network.target confluent-server.target

[Service]
Type=simple
User=cp-kafka-connect
Group=confluent
ExecStart=/usr/bin/replicator /etc/kafka-connect-replicator/replicator-connect-distributed.properties
TimeoutStopSec=180
Restart=no

[Install]
WantedBy=multi-user.target
EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-replicator.service.d/override.conf
[Service]
SuccessExitStatus=143

User=
Group=
User=${USER}
Group=${GROUP}

Environment=
EnvironmentFile=${CONFLUENT_HOME}/services/${SERVER_NAME}-service.env

ExecStart=
ExecStart=/usr/bin/replicator ${PROPERTIES_FILE}
EOF

######################################################################

sudo systemctl daemon-reload
