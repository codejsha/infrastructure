#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

######################################################################

mkdir -p ${LOG_DIR}/domain
mkdir -p ${LOG_DIR}/dump

ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}
