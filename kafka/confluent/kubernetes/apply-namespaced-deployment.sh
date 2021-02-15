#!/bin/bash

INSTALL_SCRIPT_DIR="/svc/infrastructure/kafka/confluent"
OPERATOR_HOME="${INSTALL_SCRIPT_DIR}/confluent-operator"

cd ${OPERATOR_HOME}

kubectl apply --filename resources/crds --namespace confluent-operator
kubectl apply --filename namespaced-deployment-role.yaml --namespace confluent-operator
kubectl apply --filename namespaced-deployment-rolebinding.yaml --namespace confluent-operator

rm ${OPERATOR_HOME}/helm/confluent-operator/charts/operator/templates/clusterrole.yaml
rm ${OPERATOR_HOME}/helm/confluent-operator/charts/operator/templates/clusterrolebinding.yaml
