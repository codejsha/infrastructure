#!/bin/bash

PROJECT="myproject"
SERVER="*"
NAMESPACE="*"
URL="*"
GROUP="*"
KIND="*"

argocd proj create ${PROJECT}
argocd proj add-destination ${PROJECT} ${SERVER} ${NAMESPACE}
argocd proj add-source ${PROJECT} ${URL}
argocd proj allow-cluster-resource ${PROJECT} ${GROUP} ${KIND}
