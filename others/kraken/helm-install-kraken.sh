#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="kraken-system"

if [ ! -d "kraken" ]; then
    git clone https://github.com/uber/kraken
    # gh repo clone uber/kraken
fi

helm upgrade --install my-kraken \
    --create-namespace \
    --namespace ${NAMESPACE} \
    ./kraken/helm
