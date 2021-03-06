#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

helm repo add jenkins https://charts.jenkins.io
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="jenkins-system"

# helm install my-jenkins \
helm upgrade --install my-jenkins \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 3.0.12 \
    jenkins/jenkins
