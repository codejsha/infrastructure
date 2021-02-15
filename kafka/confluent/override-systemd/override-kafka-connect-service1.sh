#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-connect.service.d
# mkdir -p /mnt/kafka-connect1/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-connect.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-kafka-connect
# Group=confluent

# Environment=
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/mnt/kafka-connect1/logs"
Environment="CLASSPATH=/usr/share/java/kafka-connect-replicator/*"
# Environment="CLASSPATH="/usr/local/confluent/share/java/kafka-connect-replicator/*"

ExecStart=
# ExecStart=/usr/bin/connect-distributed /etc/kafka/connect-distributed.properties
# ExecStart=/usr/bin/connect-distributed /etc/schema-registry/connect-avro-distributed.properties
# ExecStart=/usr/bin/connect-distributed /etc/confluent/properties/connect-distributed.properties
ExecStart=/usr/bin/connect-distributed /etc/confluent/properties/connect-avro-distributed.properties
EOF

sudo systemctl daemon-reload
