#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-zookeeper.service.d
# mkdir -p /confluent/zookeeper2/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-zookeeper.service.d/override.conf
[Service]
# User=
# Group=
Environment=
ExecStart=

# User=cp-kafka
# Group=confluent
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/confluent/zookeeper2/logs"
# ExecStart=/usr/bin/zookeeper-server-start /etc/kafka/zookeeper.properties
ExecStart=/usr/bin/zookeeper-server-start /etc/confluent/properties/zookeeper2.properties
EOF

sudo systemctl daemon-reload
