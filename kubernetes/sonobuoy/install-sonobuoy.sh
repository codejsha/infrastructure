#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

SONOBUOY_VERSION="0.50.0"

curl -LJO https://github.com/vmware-tanzu/sonobuoy/releases/download/v${SONOBUOY_VERSION}/sonobuoy_${SONOBUOY_VERSION}_linux_amd64.tar.gz
tar -xzf sonobuoy_${SONOBUOY_VERSION}_linux_amd64.tar.gz
sudo mv sonobuoy /usr/local/bin
sudo chown root:root /usr/local/bin/sonobuoy

rm -f LICENSE sonobuoy_${SONOBUOY_VERSION}_linux_amd64.tar.gz
