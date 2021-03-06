#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

### usage:
### bash ./harbor-push-helm.sh <CHART_PATH> [TAG]

CHART_PATH="${1}"
TAG="${2:-latest}"

HARBOR_URL="core.harbor.example.com"
PROJECT="myproject"
REPOSITORY="myrepo"

if [ -z "${CHART_PATH}" ]; then
    echo "Usage: bash ./harbor-push-helm.sh <CHART_PATH> [TAG]"
    exit
fi

helm chart save ${CHART_PATH} ${HARBOR_URL}/${PROJECT}/${REPOSITORY}:${TAG}
helm chart push ${HARBOR_URL}/${PROJECT}/${REPOSITORY}:${TAG}
