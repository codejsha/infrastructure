#!/bin/bash

git clone https://github.com/kubernetes-sigs/descheduler.git
# gh repo clone kubernetes-sigs/descheduler

kubectl create -f descheduler/kubernetes/rbac.yaml
kubectl create -f descheduler/kubernetes/configmap.yaml

### Run as a job
# kubectl create -f descheduler/kubernetes/job.yaml

### Run as a cronjob
kubectl create -f descheduler/kubernetes/cronjob.yaml

### Delete
# kubectl delete -f descheduler/kubernetes/cronjob.yaml
# kubectl delete -f descheduler/kubernetes/configmap.yaml
# kubectl delete -f descheduler/kubernetes/rbac.yaml
