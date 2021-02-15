#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-schema-registry.service.d
# mkdir -p /mnt/schema-registry1/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-schema-registry.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-schema-registry
# Group=confluent

# Environment=
# Environment="LOG_DIR=/var/log/confluent/schema-registry"
# Environment="LOG_DIR=/mnt/schema-registry1/logs"

ExecStart=
# ExecStart=/usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties
ExecStart=/usr/bin/schema-registry-start /etc/confluent/properties/schema-registry1.properties
EOF

sudo systemctl daemon-reload
