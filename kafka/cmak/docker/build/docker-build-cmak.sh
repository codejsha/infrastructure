#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# docker image build --tag registry.example.com/cmak:latest .
# docker image push registry.example.com/cmak:latest

docker image build --tag core.harbor.example.com/library/cmak:latest .
docker image push core.harbor.example.com/library/cmak:latest
