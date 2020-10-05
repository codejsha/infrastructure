#!/usr/bin/bash

NAMESPACE="kraken-system"
kubectl create namespace ${NAMESPACE}

if [ ! -d "kraken" ]; then
    git clone https://github.com/uber/kraken
fi

helm install my-kraken \
    --namespace ${NAMESPACE} \
    --values override.yaml \
    ./kraken/helm
