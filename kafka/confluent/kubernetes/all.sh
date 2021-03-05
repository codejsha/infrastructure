#!/bin/bash

bash ./helm-install-confluent-operator.sh
bash ./helm-install-confluent-zookeeper.sh
bash ./helm-install-confluent-kafka.sh
bash ./helm-install-confluent-schema-registry.sh
bash ./helm-install-confluent-kafka-connect.sh
bash ./helm-install-confluent-replicator.sh
bash ./helm-install-confluent-ksql.sh
bash ./helm-install-confluent-control-center.sh
