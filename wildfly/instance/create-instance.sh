#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

######################################################################

mkdir -p ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/configuration ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/deployments ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/lib ${JBOSS_BASE_DIR}
/bin/cp -rpf ${JBOSS_HOME}/standalone/tmp ${JBOSS_BASE_DIR}
mkdir -p ${JBOSS_LOG_DIR}/backup
mkdir -p ${JBOSS_LOG_DIR}/dump
