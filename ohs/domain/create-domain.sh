#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${DOMAIN_HOME}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"

######################################################################

function ohs_create_domain {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_domain.py
}

function ohs_create_domain_12cr1 {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_domain_12cr1.py
}

######################################################################

ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}

######################################################################

ohs_create_domain
# ohs_create_domain_12cr1
