#!/bin/bash

helm repo add jenkins https://charts.jenkins.io
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./chart-values.yaml > ./chart-values-temp.yaml

NAMESPACE="jenkins-system"

# helm install my-jenkins \
helm upgrade --install my-jenkins \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values-temp.yaml \
    --version 3.0.12 \
    jenkins/jenkins
