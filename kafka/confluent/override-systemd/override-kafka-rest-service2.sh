#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-rest.service.d
# mkdir -p /confluent/kafka-rest2/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-rest.service.d/override.conf
[Service]
# User=
# Group=
Environment=
ExecStart=

# User=cp-kafka-rest
# Group=confluent
Environment="LOG_DIR=/var/log/confluent/kafka-rest"
# Environment="LOG_DIR=/confluent/kafka-rest2/logs"
# ExecStart=/usr/bin/kafka-rest-start /etc/kafka-rest/kafka-rest.properties
ExecStart=/usr/bin/kafka-rest-start /etc/confluent/properties/kafka-rest2.properties
EOF

sudo systemctl daemon-reload
