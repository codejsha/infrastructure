#!/bin/bash

NAMESPACE="kraken-system"

if [ ! -d "kraken" ]; then
    git clone https://github.com/uber/kraken
    # gh repo clone uber/kraken
fi

helm upgrade --install my-kraken \
    --create-namespace \
    --namespace ${NAMESPACE} \
    ./kraken/helm