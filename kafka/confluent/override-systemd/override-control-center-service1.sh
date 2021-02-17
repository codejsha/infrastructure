#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-control-center.service.d
# mkdir -p /mnt/control-center/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-control-center.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-control-center
# Group=confluent

# Environment=
# Environment="LOG_DIR=/var/log/confluent/control-center" "CONTROL_CENTER_LOG4J_OPTS=-Dlog4j.configuration=file:/etc/confluent-control-center/log4j-rolling.properties"
# Environment="LOG_DIR=/mnt/control-center/logs" "CONTROL_CENTER_LOG4J_OPTS=-Dlog4j.configuration=file:/etc/confluent-control-center/log4j-rolling.properties"

ExecStart=
# ExecStart=/usr/bin/control-center-start /etc/confluent-control-center/control-center-dev.properties
# ExecStart=/usr/bin/control-center-start /etc/confluent-control-center/control-center-minimal.properties
# ExecStart=/usr/bin/control-center-start /etc/confluent-control-center/control-center-production.properties
# ExecStart=/usr/bin/control-center-start /etc/confluent-control-center/control-center.properties
ExecStart=/usr/bin/control-center-start /etc/confluent/properties/control-center-production1.properties
EOF

sudo systemctl daemon-reload
