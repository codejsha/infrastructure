#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

kubectl get secret rook-ceph-dashboard-password --namespace rook-ceph --output jsonpath="{['data']['password']}" | base64 --decode && echo
