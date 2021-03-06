#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

export UUID="$(uuidgen)"
export SECONDS_SINCE="$(date +%s)"

envsubst < ./appproj.yaml > ./appproj-temp.yaml

kubectl apply --filename appproj-temp.yaml
