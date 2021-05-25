#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-connect.service.d
# sudo mkdir -p /mnt/kafka-connect/logs
# sudo chown -R cp-kafka-connect:confluent /mnt/kafka-connect

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-connect.service.d/override.conf
[Service]
# User=
# Group=
# User=cp-kafka-connect
# Group=confluent

# Environment=
Environment="LOG_DIR=/var/log/kafka"
Environment="CLASSPATH=/usr/share/java/kafka-connect-replicator/*"
# Environment="LOG_DIR=/mnt/kafka-connect/logs"
# Environment="CLASSPATH="/usr/local/confluent/share/java/kafka-connect-replicator/*"

ExecStart=
# ExecStart=/usr/bin/connect-standalone /etc/kafka/connect-standalone.properties
# ExecStart=/usr/bin/connect-standalone /etc/schema-registry/connect-avro-standalone.properties
# ExecStart=/usr/bin/connect-distributed /etc/kafka/connect-distributed.properties
# ExecStart=/usr/bin/connect-distributed /etc/schema-registry/connect-avro-distributed.properties
ExecStart=/usr/bin/connect-distributed /usr/local/confluent/properties/kafka-connect1.properties
EOF

sudo systemctl daemon-reload
