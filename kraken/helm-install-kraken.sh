#!/usr/bin/bash

NAMESPACE="kraken-system"

if [ ! -d "kraken" ]; then
    git clone https://github.com/uber/kraken
fi

helm upgrade --install my-kraken \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values.yaml \
    ./kraken/helm
