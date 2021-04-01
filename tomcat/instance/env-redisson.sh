#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# REDISSON_MODE="CLUSTER_MODE"
REDISSON_MODE="MASTER_SLAVE_MODE"
# REDISSON_MODE="SINGLE_MODE"
