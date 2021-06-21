#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"

######################################################################

### escape forward slash
ORACLE_HOME="${ORACLE_HOME//\//\\/}"
DOMAIN_NAME="${DOMAIN_NAME//\//\\/}"
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR//\//\\/}"

######################################################################

perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/" env-base.sh
perl -pi -e "s/DOMAIN_NAME=.*/DOMAIN_NAME=\"${DOMAIN_NAME}\"/" env-base.sh
perl -pi -e "s/INSTALL_SCRIPT_DIR=.*/INSTALL_SCRIPT_DIR=\"${INSTALL_SCRIPT_DIR}\"/" env-base.sh
perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=${ORACLE_HOME}/" response-sw-only.rsp
