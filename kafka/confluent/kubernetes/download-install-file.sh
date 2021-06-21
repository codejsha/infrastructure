#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

if [ ! -d "confluent-operator" ]; then
    curl -LJO https://platform-ops-bin.s3-us-west-1.amazonaws.com/operator/confluent-operator-1.7.0.tar.gz
    mkdir confluent-operator
    tar -xzf confluent-operator-1.7.0.tar.gz -C confluent-operator
fi
