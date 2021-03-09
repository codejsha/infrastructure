#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

if [ ! -d "confluent-operator" ]; then
    curl -LJO https://platform-ops-bin.s3-us-west-1.amazonaws.com/operator/confluent-operator-1.7.0.tar.gz
    mkdir confluent-operator
    tar -xzf confluent-operator-1.7.0.tar.gz -C confluent-operator
fi

bash ./helm-install-confluent-operator.sh
bash ./wait-pod-ready-status.sh "app=cc-operator"

bash ./set-security-context-openshift.sh

bash ./helm-install-confluent-zookeeper.sh
bash ./wait-pod-ready-status.sh "type=zookeeper"

bash ./helm-install-confluent-kafka.sh
bash ./wait-pod-ready-status.sh "type=kafka"

bash ./helm-install-confluent-schema-registry.sh
bash ./wait-pod-ready-status.sh "type=schemaregistry"

bash ./helm-install-confluent-kafka-connect.sh
bash ./wait-pod-ready-status.sh "type=connectors"

bash ./helm-install-confluent-replicator.sh
bash ./wait-pod-ready-status.sh "type=replicator"

bash ./helm-install-confluent-ksqldb.sh
bash ./wait-pod-ready-status.sh "type=ksql"

bash ./helm-install-confluent-control-center.sh
bash ./wait-pod-ready-status.sh "type=controlcenter"

### uninstall
# helm uninstall confluent-control-center
# helm uninstall confluent-ksqldb
# helm uninstall confluent-replicator
# helm uninstall confluent-kafka-connect
# helm uninstall confluent-schema-registry
# helm uninstall confluent-kafka
# helm uninstall confluent-zookeeper
# helm uninstall confluent-operator
