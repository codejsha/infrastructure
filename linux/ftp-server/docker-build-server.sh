#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# docker image build .
docker image build --tag ftp-server:latest .
# docker image build --file Dockerfile --tag ftp-server:latest .
