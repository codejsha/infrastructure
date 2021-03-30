#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# docker image build --tag registry.example.com/kustomize-cli:v3.8.6 .
# docker image push registry.example.com/kustomize-cli:v3.8.6

docker image build --tag core.harbor.example.com/library/kustomize-cli:v3.8.6 .
docker image push core.harbor.example.com/library/kustomize-cli:v3.8.6
