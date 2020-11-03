#!/usr/bin/bash

ORACLE_HOME="/usr/local/ohs"

######################################################################

function check_version_by_directory {
    ls ${ORACLE_HOME}/inventory/Components/oracle.ohs2
}

function check_version_by_httpd {
    export ORACLE_HOME=${ORACLE_HOME}
    export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib:${ORACLE_HOME}/oracle_common/lib
    ${ORACLE_HOME}/ohs/bin/httpd -V
}

######################################################################

# check_version_by_directory
check_version_by_httpd
