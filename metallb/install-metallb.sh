#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### Enable strict ARP mode
# kubectl edit configmap kube-proxy --namespace kube-system
### ---
### apiVersion: kubeproxy.config.k8s.io/v1alpha1
### kind: KubeProxyConfiguration
### mode: "ipvs"
### ipvs:
###   strictARP: true
### ---

### see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy --namespace kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff --namespace kube-system --filename -

### actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy --namespace kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply --namespace kube-system --filename -

kubectl apply --filename https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply --filename https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml

kubectl apply --filename configmap.yaml
# kubectl apply --filename configmap-kind.yaml
# kubectl apply --filename configmap-minikube.yaml

### On first install only
kubectl create secret generic --namespace metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
