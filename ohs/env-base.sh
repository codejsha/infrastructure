#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

export ORACLE_HOME="/usr/local/ohs"
export MW_HOME="${ORACLE_HOME}"
export DOMAIN_NAME="base_domain"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
export NODE_MANAGER_NAME="localmachine"
export NODE_MANAGER_LISTEN_ADDRESS="localhost"
export NODE_MANAGER_LISTEN_PORT="5556"
export NODE_MANAGER_USERNAME="ohs"
export NODE_MANAGER_PASSWORD="welcome1"
export LOG_DIR="${DOMAIN_HOME}/logs"

INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"
