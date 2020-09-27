#!/usr/bin/bash

TEKTON_CLI_VERSION="0.11.0"

curl -LJO https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/tkn_${TEKTON_CLI_VERSION}_Linux_x86_64.tar.gz
sudo tar -zxf tkn_${TEKTON_CLI_VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn

# curl -LJO https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/tektoncd-cli-${TEKTON_CLI_VERSION}_Linux-64bit.rpm
# sudo rpm -Uvh tektoncd-cli-${TEKTON_CLI_VERSION}_Linux-64bit.rpm
