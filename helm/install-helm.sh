#!/bin/bash

HELM_VERSION="3.3.1"
curl -LJO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
sudo chown root:root /usr/local/bin/helm

# HELM_VERSION="2.16.10"
# curl -LJO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
# tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
# sudo mv linux-amd64/helm /usr/local/bin/helm
# sudo chown root:root /usr/local/bin/helm

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com
helm repo list
helm repo update
