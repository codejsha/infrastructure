#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-ksqldb.service.d
# mkdir -p /confluent/ksqldb1/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-ksqldb.service.d/override.conf
[Service]
# User=
# Group=
Environment=
ExecStart=

# User=cp-ksql
# Group=confluent
Environment="LOG_DIR=/var/log/confluent/ksql"
# Environment="LOG_DIR=/confluent/ksqldb1/logs"
# ExecStart=/usr/bin/ksql-server-start /etc/ksqldb/ksql-server.properties
ExecStart=/usr/bin/ksql-server-start /etc/confluent/properties/ksql-server1.properties
EOF

sudo systemctl daemon-reload
