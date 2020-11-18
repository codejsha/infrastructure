#!/usr/bin/bash

source ./env-base.sh

ORACLE_HOME="${ORACLE_HOME}"
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR}"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${INSTALL_SCRIPT_DIR}/delete_component.py
