#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### Run as a job
# kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/job?ref=master' | kubectl apply --filename -

### Run as a cronjob
kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/cronjob?ref=master' | kubectl apply --filename -

### Delete
# kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/job?ref=master' | kubectl delete --filename -
# kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/cronjob?ref=master' | kubectl delete --filename -
