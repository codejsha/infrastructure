#!/usr/bin/bash

source ./env-base.sh

INSTANCE_NAME="${1:-INSTANCE_NAME}"
PORT_OFFSET="${2:-PORT_OFFSET}"

######################################################################

mkdir -p ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/configuration ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/deployments ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/lib ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/tmp ${JBOSS_BASE_DIR}
mkdir -p ${JBOSS_LOG_DIR}/${INSTANCE_NAME}
mkdir -p ${DUMP_LOG_DIR}
