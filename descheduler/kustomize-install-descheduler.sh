#!/bin/bash

### Run as a job
# kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/job?ref=master' | kubectl apply -f -

### Run as a cronjob
kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/cronjob?ref=master' | kubectl apply -f -

### Delete
# kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/job?ref=master' | kubectl delete -f -
# kustomize build 'github.com/kubernetes-sigs/descheduler/kubernetes/cronjob?ref=master' | kubectl delete -f -
