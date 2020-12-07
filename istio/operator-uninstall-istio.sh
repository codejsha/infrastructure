#!/bin/bash

### clean up resources
istioctl manifest generate | kubectl delete -f -
kubectl delete ns istio-system --grace-period=0 --force

### delete the istio operator
istioctl operator remove
# kubectl delete ns istio-operator --grace-period=0 --force
