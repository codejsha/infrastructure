#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

INSTANCE_NAME="${INSTANCE_NAME}"
JBOSS_HOME="${JBOSS_HOME}"
JBOSS_BASE_DIR="${JBOSS_BASE_DIR}"
JBOSS_LOG_DIR="${JBOSS_LOG_DIR}"

######################################################################

mkdir -p ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/configuration ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/deployments ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/lib ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/tmp ${JBOSS_BASE_DIR}
mkdir -p ${JBOSS_LOG_DIR}/${INSTANCE_NAME}
mkdir -p ${JBOSS_LOG_DIR}/dump
