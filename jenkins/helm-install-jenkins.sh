#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add jenkins https://charts.jenkins.io
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./values.yaml > ./values-temp.yaml

NAMESPACE="jenkins-system"

# helm install my-jenkins \
helm upgrade --install my-jenkins \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values-temp.yaml \
    --version 3.0.12 \
    jenkins/jenkins
