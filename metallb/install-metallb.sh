#!/bin/bash
# https://metallb.universe.tf/installation/

NAMESPACE="metallb-system"
kubectl create namespace ${NAMESPACE}

### Enable strict ARP mode
# kubectl edit configmap kube-proxy -n kube-system 
### ---
### apiVersion: kubeproxy.config.k8s.io/v1alpha1
### kind: KubeProxyConfiguration
### mode: "ipvs"
### ipvs:
###   strictARP: true
### ---

# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f namespace.yaml
kubectl apply -f metallb.yaml
kubectl apply -f configmap.yaml

### On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
