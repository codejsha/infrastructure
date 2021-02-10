#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-server.service.d
# mkdir -p /confluent/kafka2/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-server.service.d/override.conf
[Service]
# User=
# Group=
Environment=
ExecStart=

# User=cp-kafka
# Group=confluent
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/confluent/kafka2/logs"
# ExecStart=/usr/bin/kafka-server-start /etc/kafka/server.properties
ExecStart=/usr/bin/kafka-server-start /etc/confluent/properties/server2.properties
EOF

sudo systemctl daemon-reload
