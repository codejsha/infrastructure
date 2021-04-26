#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-rest.service.d
# sudo mkdir -p /mnt/kafka-rest/logs
# sudo chown -R cp-kafka-rest:confluent /mnt/kafka-rest

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-rest.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-kafka-rest
# Group=confluent

# Environment=
Environment="LOG_DIR=/var/log/confluent/kafka-rest"
# Environment="LOG_DIR=/mnt/kafka-rest/logs"

ExecStart=
# ExecStart=/usr/bin/kafka-rest-start /etc/kafka-rest/kafka-rest.properties
ExecStart=/usr/bin/kafka-rest-start /etc/confluent/properties/kafka-rest1.properties
EOF

sudo systemctl daemon-reload
