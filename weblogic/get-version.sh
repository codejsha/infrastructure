#!/bin/bash

source ./env-base.sh

ORACLE_HOME="${ORACLE_HOME}"
MAJOR_VERSION="${MAJOR_VERSION}"    # (available: 11g, 12c, 14c)

######################################################################

function get_version {
    if [ "${MAJOR_VERSION}" == "11g" ]; then
        MW_HOME="${ORACLE_HOME}"
        grep "WebLogic Server" ${MW_HOME}/registry.xml
    elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
        grep "WebLogic Server" ${ORACLE_HOME}/inventory/registry.xml
    fi
}

######################################################################

get_version
