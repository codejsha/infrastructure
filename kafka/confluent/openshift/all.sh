#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

bash ./download-install-file.sh
bash ./set-security-context.sh

bash ./helm-install-confluent-operator.sh
bash ./wait-pod-ready-status.sh "app=cc-operator"

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
# helm uninstall --namespace confluent-operator confluent-control-center
# helm uninstall --namespace confluent-operator confluent-ksqldb
# helm uninstall --namespace confluent-operator confluent-replicator
# helm uninstall --namespace confluent-operator confluent-kafka-connect
# helm uninstall --namespace confluent-operator confluent-schema-registry
# helm uninstall --namespace confluent-operator confluent-kafka
# helm uninstall --namespace confluent-operator confluent-zookeeper
# helm uninstall --namespace confluent-operator confluent-operator
