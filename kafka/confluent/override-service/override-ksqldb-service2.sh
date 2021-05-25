#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-ksqldb.service.d
# sudo mkdir -p /mnt/ksqldb/logs
# sudo chown -R cp-ksql:confluent /mnt/ksqldb

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-ksqldb.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-ksql
# Group=confluent

# Environment=
Environment="LOG_DIR=/var/log/confluent/ksql"
# Environment="LOG_DIR=/mnt/ksqldb/logs"

ExecStart=
# ExecStart=/usr/bin/ksql-server-start /etc/ksqldb/ksql-production-server.properties
# ExecStart=/usr/bin/ksql-server-start /etc/ksqldb/ksql-server.properties
ExecStart=/usr/bin/ksql-server-start /usr/local/confluent/properties/ksqldb2.properties
EOF

sudo systemctl daemon-reload
