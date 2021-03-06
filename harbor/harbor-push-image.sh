#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

### usage:
### bash ./harbor-push-image.sh <SOURCE_IMAGE> [TAG]

SOURCE_IMAGE="${1}"
TAG="${2:-latest}"

HARBOR_URL="core.harbor.example.com"
PROJECT="myproject"
REPOSITORY="myrepo"

if [ -z "${SOURCE_IMAGE}" ]; then
    echo "Usage: bash ./harbor-push-image.sh <SOURCE_IMAGE> [TAG]"
    exit
fi

docker tag ${SOURCE_IMAGE}:${TAG} ${HARBOR_URL}/${PROJECT}/${REPOSITORY}:${TAG}
docker push ${HARBOR_URL}/${PROJECT}/${REPOSITORY}:${TAG}
