#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# HELM_VERSION="3.5.1"
# curl -LJO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
# tar -xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
# sudo mv linux-amd64/helm /usr/local/bin/helm
# sudo chown root:root /usr/local/bin/helm

# HELM_VERSION="2.17.0"
# curl -LJO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
# tar -xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
# sudo mv linux-amd64/helm /usr/local/bin/helm
# sudo chown root:root /usr/local/bin/helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
sudo ./get_helm.sh
rm -f get_helm.sh

# helm repo add stable https://charts.helm.sh/stable
# helm repo add incubator https://charts.helm.sh/incubator
# helm repo list
# helm repo update
