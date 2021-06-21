#!/bin/bash

# USER="cp-kafka"
# GROUP="confluent"
USER=""
GROUP=""

CONFLUENT_HOME=""
SERVER_NAME=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/server.properties"
PROPERTIES_FILE=""

# DATA_DIR="/var/lib/kafka"
# LOG_DIR="/var/log/kafka"
DATA_DIR=""
LOG_DIR=""

######################################################################

sudo mkdir -p /usr/lib/systemd/system/confluent-server.service.d
sudo mkdir -p {${DATA_DIR},${LOG_DIR}}
sudo chown -R ${USER}:${GROUP} ${DATA_DIR} ${LOG_DIR}

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-server.service
[Unit]
Description=Apache Kafka - broker
Documentation=http://docs.confluent.io/
After=network.target confluent-zookeeper.target

[Service]
Type=simple
User=cp-kafka
Group=confluent
ExecStart=/usr/bin/kafka-server-start /etc/kafka/server.properties
LimitNOFILE=1000000
TimeoutStopSec=180
Restart=no

[Install]
WantedBy=multi-user.target
EOF

######################################################################

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-server.service.d/override.conf
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
