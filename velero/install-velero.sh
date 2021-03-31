#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

VELERO_VERSION="1.5.3"

curl -LJO https://github.com/vmware-tanzu/velero/releases/download/v${VELERO_VERSION}/velero-v${VELERO_VERSION}-linux-amd64.tar.gz
tar -xzf velero-v${VELERO_VERSION}-linux-amd64.tar.gz
cd velero-v${VELERO_VERSION}-linux-amd64
sudo mv velero /usr/local/bin
sudo chown root:root /usr/local/bin/velero

velero version

### autocompletion
sudo yum install -y bash-completion
source <(velero completion bash)
sudo velero completion bash | sudo tee /etc/bash_completion.d/velero
