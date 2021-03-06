#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

JBOSS_BASE_DIR="${JBOSS_BASE_DIR}"

grep -v "^#" ${JBOSS_BASE_DIR}/configuration/mgmt-users.properties
