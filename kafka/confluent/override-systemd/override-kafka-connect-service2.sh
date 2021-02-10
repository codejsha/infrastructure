#!/bin/bash

sudo mkdir -p /usr/lib/systemd/system/confluent-kafka-connect.service.d
# mkdir -p /confluent/kafka-connect2/logs

cat <<EOF | sudo tee /usr/lib/systemd/system/confluent-kafka-connect.service.d/override.conf
[Service]
# User=
# Group=
Environment=
ExecStart=

# User=cp-kafka-connect
# Group=confluent
Environment="LOG_DIR=/var/log/kafka"
# Environment="LOG_DIR=/confluent/kafka-connect2/logs"
Environment="CLASSPATH=${CLASSPATH}:/usr/share/java/kafka-connect-replicator/*"
# Environment="CLASSPATH="${CLASSPATH}:/usr/local/confluent/share/java/kafka-connect-replicator/*"
# ExecStart=/usr/bin/connect-distributed /etc/kafka/connect-distributed.properties
# ExecStart=/usr/bin/connect-distributed /etc/confluent/properties/connect-distributed.properties
ExecStart=/usr/bin/connect-distributed /etc/confluent/properties/connect-avro-distributed.properties
EOF

sudo systemctl daemon-reload
