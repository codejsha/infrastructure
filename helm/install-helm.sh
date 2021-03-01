#!/bin/bash

# HELM_VERSION="3.5.1"
# curl -LJO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
# tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
# sudo mv linux-amd64/helm /usr/local/bin/helm
# sudo chown root:root /usr/local/bin/helm

# HELM_VERSION="2.17.0"
# curl -LJO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
# tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
# sudo mv linux-amd64/helm /usr/local/bin/helm
# sudo chown root:root /usr/local/bin/helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
sudo ./get_helm.sh

# helm repo add stable https://kubernetes-charts.storage.googleapis.com
# helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com
# helm repo list
# helm repo update
