#!/bin/bash

NAMESPACE="kafka-system"

helm repo add strimzi https://strimzi.io/charts
helm repo update

# helm install my-kafka-operator \
helm upgrade --install my-kafka-operator \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --version 0.20.0 \
    strimzi/strimzi-kafka-operator

    # --values strimzi-values.yaml \

kubectl apply --filename strimzi-kafka-cluster.yaml
