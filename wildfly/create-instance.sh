#!/bin/bash

source ./env-base.sh

INSTANCE_NAME="${INSTANCE_NAME}"
JBOSS_HOME="${JBOSS_HOME}"
JBOSS_BASE_DIR="${JBOSS_BASE_DIR}"
JBOSS_LOG_DIR="${JBOSS_LOG_DIR}"
DUMP_LOG_DIR="${DUMP_LOG_DIR}"

######################################################################

mkdir -p ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/configuration ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/deployments ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/lib ${JBOSS_BASE_DIR}
/usr/bin/cp -rpf ${JBOSS_HOME}/standalone/tmp ${JBOSS_BASE_DIR}
mkdir -p ${JBOSS_LOG_DIR}/${INSTANCE_NAME}
mkdir -p ${DUMP_LOG_DIR}
