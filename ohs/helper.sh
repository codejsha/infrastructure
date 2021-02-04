#!/bin/bash

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"

ORACLE_HOME="${ORACLE_HOME//\//\/}"
DOMAIN_NAME="${DOMAIN_NAME//\//\/}"
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR//\//\/}"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/DOMAIN_NAME=.*/DOMAIN_NAME=\"${DOMAIN_NAME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/INSTALL_SCRIPT_DIR=.*/INSTALL_SCRIPT_DIR=\"${INSTALL_SCRIPT_DIR}\"/"
perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=${ORACLE_HOME}/" ${INSTALL_SCRIPT_DIR}/ohs/response-sw-only.rsp
