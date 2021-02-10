#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-zookeeper.service.d
# mkdir -p /confluent/zookeeper1/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-zookeeper.service.d/override.conf
[Service]
# User=
# Group=
Environment=
ExecStart=

# User=cp-kafka
# Group=confluent
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/confluent/zookeeper1/logs"
# ExecStart=/usr/bin/zookeeper-server-start /etc/kafka/zookeeper.properties
ExecStart=/usr/bin/zookeeper-server-start /etc/confluent/properties/zookeeper1.properties
EOF

sudo systemctl daemon-reload
