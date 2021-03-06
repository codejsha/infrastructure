#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o errexit
set -o errtrace
set -o xtrace

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
COMPONENT_NAME="ohs1"
NODE_MANAGER_LISTEN_ADDRESS="localhost"
NODE_MANAGER_LISTEN_PORT="5556"
NODE_MANAGER_USERNAME="ohs"
NODE_MANAGER_PASSWORD="welcome1"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/get_dump_metrics.py
