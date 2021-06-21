#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ./env-base.sh

ORACLE_HOME="${ORACLE_HOME}"

######################################################################

function get_version_with_directory {
    ls ${ORACLE_HOME}/inventory/Components/oracle.ohs2
}

function get_version_with_httpd {
    export ORACLE_HOME="${ORACLE_HOME}"
    export LD_LIBRARY_PATH="${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib:${ORACLE_HOME}/oracle_common/lib"
    ${ORACLE_HOME}/ohs/bin/httpd -V
}

######################################################################

# get_version_with_directory
get_version_with_httpd
