#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-component.sh

ORACLE_HOME="${ORACLE_HOME}"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_component.py
