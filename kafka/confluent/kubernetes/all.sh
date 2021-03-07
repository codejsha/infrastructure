#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

kubectl create namespace confluent-operator

curl -LJO https://platform-ops-bin.s3-us-west-1.amazonaws.com/operator/confluent-operator-1.7.0.tar.gz
mkdir confluent-operator
tar -xzf confluent-operator-1.7.0.tar.gz -C confluent-operator

bash ./helm-install-confluent-operator.sh
bash ./helm-install-confluent-zookeeper.sh
bash ./helm-install-confluent-kafka.sh
bash ./helm-install-confluent-schema-registry.sh
bash ./helm-install-confluent-kafka-connect.sh
bash ./helm-install-confluent-replicator.sh
bash ./helm-install-confluent-ksqldb.sh
bash ./helm-install-confluent-control-center.sh
