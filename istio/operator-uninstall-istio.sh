#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### clean up resources
istioctl manifest generate | kubectl delete --filename -
kubectl delete ns istio-system --grace-period=0 --force

### delete the istio operator
istioctl operator remove
# kubectl delete ns istio-operator --grace-period=0 --force
