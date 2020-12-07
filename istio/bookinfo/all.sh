#!/bin/bash

NAMESPACE="bookinfo"
kubectl create namespace ${NAMESPACE}
kubectl label namespace bookinfo istio-injection=enabled
kubectl config set-context --current --namespace="${NAMESPACE}"

### deploy bookinfo
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo.yaml
# kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-details-v2.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-db.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-ratings-v2.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-mysql.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-ratings-v2-mysql.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-ratings-v2-mysql-vm.yaml

### check bookinfo
# kubectl get services
# kubectl get pods
# kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') \
#     -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"

### deploy networking
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/destination-rule-all.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/bookinfo-gateway.yaml

### check bookinfo gateway
# kubectl get gateways
# istioctl analyze
# kubectl get services istio-ingressgateway -n istio-system

### delete
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/bookinfo-gateway.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-details-v2.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-db.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-ratings-v2.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-mysql.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-ratings-v2-mysql.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo-ratings-v2-mysql-vm.yaml
