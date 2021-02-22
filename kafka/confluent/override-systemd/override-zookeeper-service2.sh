#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-zookeeper.service.d
# mkdir -p /mnt/zookeeper/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-zookeeper.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-kafka
# Group=confluent

# Environment=
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/mnt/zookeeper/logs"

ExecStart=
# ExecStart=/usr/bin/zookeeper-server-start /etc/kafka/zookeeper.properties
ExecStart=/usr/bin/zookeeper-server-start /etc/confluent/properties/zookeeper2.properties
EOF

sudo systemctl daemon-reload