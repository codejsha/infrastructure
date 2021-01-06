#!/bin/bash

helm repo add elastic https://helm.elastic.co
helm repo update

NAMESPACE="elastic-system"

helm install elastic-operator \
    --create-namespace \
    --namespace ${NAMESPACE} \
    elastic/eck-operator
