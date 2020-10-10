#!/usr/bin/bash

# usage:
# bash ./harbor-push-helm.sh <CHART_PATH> [TAG]

CHART_PATH="${1}"
TAG="${2:-latest}"

HARBOR_URL="core.harbor.example.com"
PROJECT="myproject"
REPOSITORY="myrepo"

if [ -z "${CHART_PATH}" ]; then
    echo "usage:  bash ./harbor-push-helm.sh <CHART_PATH> [TAG]"
    exit
fi

helm chart save ${CHART_PATH} ${HARBOR_URL}/${PROJECT}/${REPOSITORY}:${TAG}
helm chart push ${HARBOR_URL}/${PROJECT}/${REPOSITORY}:${TAG}
