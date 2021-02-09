#!/bin/bash

JAVA_HOME="/usr/java/current"
MW_HOME="/usr/local/weblogic"
DOMAIN_NAME="base_domain"
ADMIN_SERVER_LISTEN_ADDRESS="test.example.com"
ADMIN_SERVER_LISTEN_PORT="7001"
INSTALL_SCRIPT_DIR="/svc/infrastructure/weblogic"

######################################################################

ORACLE_HOME="${MW_HOME}"

JAVA_HOME="${JAVA_HOME//\//\/}"
ORACLE_HOME="${ORACLE_HOME//\//\/}"

perl -pi -e "s/name=\"BEAHOME\" value=\".*\"/name=\"BEAHOME\" value=\"${ORACLE_HOME}\"/" ${INSTALL_SCRIPT_DIR}/silent.xml
perl -pi -e "s/name=\"WLS_INSTALL_DIR\" value=\".*\"/name=\"WLS_INSTALL_DIR\" value=\"${ORACLE_HOME}\/wlserver_10.3\"/" ${INSTALL_SCRIPT_DIR}/silent.xml

INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR//\//\/}"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/DOMAIN_NAME=.*/DOMAIN_NAME=\"${DOMAIN_NAME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ADMIN_SERVER_LISTEN_ADDRESS=.*/ADMIN_SERVER_LISTEN_ADDRESS=\"${ADMIN_SERVER_LISTEN_ADDRESS}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ADMIN_SERVER_LISTEN_PORT=.*/ADMIN_SERVER_LISTEN_PORT=\"${ADMIN_SERVER_LISTEN_PORT}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/INSTALL_SCRIPT_DIR=.*/INSTALL_SCRIPT_DIR=\"${INSTALL_SCRIPT_DIR}\"/"