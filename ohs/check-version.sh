#!/usr/bin/bash

ORACLE_HOME="/usr/local/ohs"
MAJOR_VERSION="12c"    # (available: 11g, 12c)

function check_version_by_directory {
    if [ "${MAJOR_VERSION}" == "11g" ]; then
        ls ${ORACLE_HOME}/inventory/Components21/oracle.ohs2
    elif [ "${MAJOR_VERSION}" == "12c" ]; then
        ls ${ORACLE_HOME}/inventory/Components/oracle.ohs2
    fi
}

function check_version_by_httpd {
    if [ "${MAJOR_VERSION}" == "11g" ]; then
        export ORACLE_HOME=${ORACLE_HOME}
        export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib
        ${ORACLE_HOME}/ohs/bin/httpd -version
    elif [ "${MAJOR_VERSION}" == "12c" ]; then
        export ORACLE_HOME=${ORACLE_HOME}
        export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib:${ORACLE_HOME}/oracle_common/lib
        ${ORACLE_HOME}/ohs/bin/httpd -version
    fi
}

# check_version_by_directory
check_version_by_httpd
