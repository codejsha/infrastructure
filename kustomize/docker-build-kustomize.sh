#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

# docker image build --tag registry.example.com/kustomize-cli:latest .
# docker image push registry.example.com/kustomize-cli:latest

docker image build --tag core.harbor.example.com/library/kustomize-cli:latest .
docker image push core.harbor.example.com/library/kustomize-cli:latest
