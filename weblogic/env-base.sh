#!/bin/bash

export JAVA_HOME="/usr/java/current"
export MAJOR_VERSION="12c"              # (available: 11g, 12c, 14c)

ORACLE_HOME="/usr/local/weblogic"
export MW_HOME="${ORACLE_HOME}"

export DOMAIN_NAME="base_domain"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
export LOG_DIR="${DOMAIN_HOME}/logs"

export ADMIN_SERVER_NAME="AdminServer"
export ADMIN_SERVER_LISTEN_ADDRESS="test.example.com"
export ADMIN_SERVER_LISTEN_PORT="7001"
export ADMIN_USERNAME="weblogic"
export ADMIN_PASSWORD="welcome1"

INSTALL_SCRIPT_DIR="/svc/infrastructure/weblogic"

######################################################################

WL_HOME=""
if [ "${MAJOR_VERSION}" == "11g" ]; then
    export WL_HOME="${MW_HOME}/wlserver_10.3"
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
    export WL_HOME="${ORACLE_HOME}/wlserver"
fi
if [ ! -d "${WL_HOME}" ]; then
    echo "[ERROR] The WL_HOME (${WL_HOME}) does not exists!"
    exit
fi
