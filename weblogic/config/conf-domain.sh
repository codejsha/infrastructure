#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

######################################################################

mkdir -p ${LOG_DIR}/domain
mkdir -p ${LOG_DIR}/dump

ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}
