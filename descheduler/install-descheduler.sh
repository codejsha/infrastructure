#!/bin/bash
# https://github.com/kubernetes-sigs/descheduler

git clone --single-branch --branch release-1.19 https://github.com/kubernetes-sigs/descheduler.git

kubectl create -f descheduler/kubernetes/rbac.yaml
kubectl create -f descheduler/kubernetes/configmap.yaml

### run as a job
# kubectl create -f descheduler/kubernetes/job.yaml

### run as a cronjob
kubectl create -f descheduler/kubernetes/cronjob.yaml
