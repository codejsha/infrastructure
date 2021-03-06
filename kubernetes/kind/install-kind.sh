#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

curl -Lo kind "https://kind.sigs.k8s.io/dl/v0.10.0/kind-$(uname)-amd64"
chmod +x kind
sudo mv kind /usr/local/bin
sudo chown root:root /usr/local/bin/kind
