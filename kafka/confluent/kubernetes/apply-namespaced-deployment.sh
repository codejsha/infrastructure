#!/bin/bash

INSTALL_SCRIPT_DIR="/svc/infrastructure/kafka/confluent/kubernetes"
OPERATOR_HOME="${INSTALL_SCRIPT_DIR}/confluent-operator"

bash ./download-install-file.sh

kubectl apply --namespace confluent-operator --filename ${OPERATOR_HOME}/resources/crds

kubectl apply --namespace confluent-operator --filename ${INSTALL_SCRIPT_DIR}/namespaced-deployment-role.yaml
kubectl apply --namespace confluent-operator --filename ${INSTALL_SCRIPT_DIR}/namespaced-deployment-rolebinding.yaml

rm -f ${OPERATOR_HOME}/helm/confluent-operator/charts/operator/templates/clusterrole.yaml
rm -f ${OPERATOR_HOME}/helm/confluent-operator/charts/operator/templates/clusterrolebinding.yaml
