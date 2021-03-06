#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

# docker image build --tag registry.example.com/example-repo-server:latest .
# docker image push registry.example.com/example-repo-server:latest

docker image build --tag core.harbor.example.com/library/example-repo-server:latest .
docker image push core.harbor.example.com/library/example-repo-server:latest
