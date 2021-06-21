#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PINPOINT_TAG="master"
# PINPOINT_TAG="2.1.0"

git clone https://github.com/naver/pinpoint-docker.git
# gh repo clone naver/pinpoint-docker

cd pinpoint-docker
git checkout ${PINPOINT_TAG}
docker-compose pull && docker-compose up -d
