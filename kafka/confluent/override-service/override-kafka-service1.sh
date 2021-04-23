#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-server.service.d
# mkdir -p /mnt/kafka/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-server.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-kafka
# Group=confluent

# Environment=
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/mnt/kafka/logs"

ExecStart=
# ExecStart=/usr/bin/kafka-server-start /etc/kafka/server.properties
ExecStart=/usr/bin/kafka-server-start /etc/confluent/properties/kafka1.properties
EOF

sudo systemctl daemon-reload
