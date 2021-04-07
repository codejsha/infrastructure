#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

JAVA_HOME="/usr/java/current"
ORACLE_HOME="/usr/local/weblogic"
DOMAIN_NAME="base_domain"
ADMIN_SERVER_LISTEN_ADDRESS="test.example.com"
ADMIN_SERVER_LISTEN_PORT="7001"
ORA_INVENTORY_LOCATION="/usr/local/oraInventory"
INSTALL_SCRIPT_DIR="/svc/infrastructure/weblogic"

######################################################################

### escape forward slash
JAVA_HOME="${JAVA_HOME//\//\\/}"
ORACLE_HOME="${ORACLE_HOME//\//\\/}"
ORA_INVENTORY_LOCATION="${ORA_INVENTORY_LOCATION//\//\\/}"

perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=${ORACLE_HOME}/" ${INSTALL_SCRIPT_DIR}/response.rsp
perl -pi -e "s/inventory_loc=.*/inventory_loc=${ORA_INVENTORY_LOCATION}/" ${INSTALL_SCRIPT_DIR}/oraInst.loc

### escape forward slash
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR//\//\\/}"

perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/" env-base.sh
perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/" env-base.sh
perl -pi -e "s/DOMAIN_NAME=.*/DOMAIN_NAME=\"${DOMAIN_NAME}\"/" env-base.sh
perl -pi -e "s/ADMIN_SERVER_LISTEN_ADDRESS=.*/ADMIN_SERVER_LISTEN_ADDRESS=\"${ADMIN_SERVER_LISTEN_ADDRESS}\"/" env-base.sh
perl -pi -e "s/ADMIN_SERVER_LISTEN_PORT=.*/ADMIN_SERVER_LISTEN_PORT=\"${ADMIN_SERVER_LISTEN_PORT}\"/" env-base.sh
perl -pi -e "s/INSTALL_SCRIPT_DIR=.*/INSTALL_SCRIPT_DIR=\"${INSTALL_SCRIPT_DIR}\"/" env-base.sh
