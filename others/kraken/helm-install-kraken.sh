#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="kraken-system"

if [ ! -d "kraken" ]; then
    git clone https://github.com/uber/kraken
    # gh repo clone uber/kraken
fi

helm upgrade --install my-kraken \
    --create-namespace \
    --namespace ${NAMESPACE} \
    ./kraken/helm
