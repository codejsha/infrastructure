#!/bin/bash

source ./env-base.sh

ORACLE_HOME="${ORACLE_HOME}"
WEBLOGIC_VERSION="${WEBLOGIC_VERSION}"

######################################################################

function get_version {
    if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
        MW_HOME="${ORACLE_HOME}"
        grep "WebLogic Server" ${MW_HOME}/registry.xml
    elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
        grep "WebLogic Server" ${ORACLE_HOME}/inventory/registry.xml
    fi
}

######################################################################

get_version
