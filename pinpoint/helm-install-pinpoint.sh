#!/bin/bash

git clone https://github.com/pinpoint-apm/pinpoint-kubernetes.git
# gh repo clone pinpoint-apm/pinpoint-kubernetes

export MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}"
export MYSQL_USERNAME="${MYSQL_USERNAME}"
export MYSQL_PASSWORD="${MYSQL_PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="pinpoint-system"

# helm install my-pinpoint \
helm upgrade --install my-pinpoint \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    ./pinpoint
