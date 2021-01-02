#!/bin/bash

export JAVA_HOME="/usr/java/current"

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

if [ ! -d "${JAVA_HOME}" ]; then
    echo "[ERROR] The JAVA_HOME (${JAVA_HOME}) does not exists!"
    exit
fi

JAVA_VERSION="$(${JAVA_HOME}/bin/java -version 2>&1 /dev/null \
        | grep version | awk '{print $3}' | tr -d '"')"

if [ ! -d "${MW_HOME}" ]; then
    echo "[ERROR] The ORACLE_HOME or MW_HOME (${MW_HOME}) does not exists!"
    exit
fi

######################################################################

### registry file
### 11g: ${MW_HOME}/registry.xml
### 12c, 14c: ${ORACLE_HOME}/inventory/registry.xml

WEBLOGIC_VERSION=""
if [ -f ${MW_HOME}/registry.xml ]; then
    WEBLOGIC_VERSION="$(grep "name=\"WebLogic Server\"" ${MW_HOME}/registry.xml \
        | grep -o -E "[0-9]{2}\.[0-9]\.[0-9]\.[0-9]")"
elif [ -f ${ORACLE_HOME}/inventory/registry.xml ]; then
    WEBLOGIC_VERSION="$(grep "name=\"WebLogic Server\"" ${ORACLE_HOME}/inventory/registry.xml \
        | grep -o -E "[0-9]{2}\.[0-9]\.[0-9]\.[0-9]\.[0-9]")"
else
    echo "[ERROR] The ORACLE_HOME or MW_HOME (${MW_HOME}) is invalid!"
    exit
fi

######################################################################

### properties file
### 11g: ${MW_HOME}/wlserver_10.3/.product.properties
### 12c, 14c: ${ORACLE_HOME}/oui/.globalEnv.properties

JAVA_HOME_FROM_PROPERTIES=""
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    JAVA_HOME_FROM_PROPERTIES="$(grep -e "^JAVA_HOME" -m -1 ${MW_HOME}/wlserver_10.3/.product.properties \
        | grep -o -E "/.*$")"
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    JAVA_HOME_FROM_PROPERTIES="$(grep -e "^JAVA_HOME" -m -1 ${ORACLE_HOME}/oui/.globalEnv.properties \
        | grep -o -E "/.*$")"
    # JAVA_HOME_FROM_PROPERTIES="$(${ORACLE_HOME}/oui/bin/getProperty.sh JAVA_HOME")"
fi

if [ "$(readlink -f ${JAVA_HOME})" != "${JAVA_HOME_FROM_PROPERTIES}" ]; then
    echo "[ERROR] The JAVA_HOME(real path) and the JAVA_HOME(from properties) are not the same!"
    exit
fi

######################################################################

WL_HOME=""
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    export WL_HOME="${MW_HOME}/wlserver_10.3"
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    export WL_HOME="${ORACLE_HOME}/wlserver"
fi

if [ ! -d "${WL_HOME}" ]; then
    echo "[ERROR] The WL_HOME (${WL_HOME}) does not exists!"
    exit
fi
