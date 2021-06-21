#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

git clone https://github.com/kubernetes-sigs/descheduler.git
# gh repo clone kubernetes-sigs/descheduler

kubectl create --filename descheduler/kubernetes/rbac.yaml
kubectl create --filename descheduler/kubernetes/configmap.yaml

### Run as a job
# kubectl create --filename descheduler/kubernetes/job.yaml

### Run as a cronjob
kubectl create --filename descheduler/kubernetes/cronjob.yaml

### Delete
# kubectl delete --filename descheduler/kubernetes/cronjob.yaml
# kubectl delete --filename descheduler/kubernetes/configmap.yaml
# kubectl delete --filename descheduler/kubernetes/rbac.yaml
