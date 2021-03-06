#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

curl -LJO https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
sudo chown root:root minio
sudo mv minio /usr/local/bin
