#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

echo "######################################################################"
echo "JAVA_HOME                     ${JAVA_HOME}"
echo "JAVA_HOME(real path)          $(readlink -f ${JAVA_HOME})"
echo "JAVA_HOME(from properties)    ${JAVA_HOME_FROM_PROPERTIES}"
echo ""
echo "ORACLE_HOME or MW_HOME        ${MW_HOME}"
echo "WL_HOME                       ${WL_HOME}"
echo ""
echo "DOMAIN_NAME                   ${DOMAIN_NAME}"
echo "DOMAIN_HOME                   ${DOMAIN_HOME}"
echo "LOG_DIR                       ${LOG_DIR}"
echo ""
echo "ADMIN_SERVER_NAME             ${ADMIN_SERVER_NAME}"
echo "ADMIN_SERVER_LISTEN_ADDRESS   ${ADMIN_SERVER_LISTEN_ADDRESS}"
echo "ADMIN_SERVER_LISTEN_PORT      ${ADMIN_SERVER_LISTEN_PORT}"
echo "ADMIN_USERNAME                ${ADMIN_USERNAME}"
echo "ADMIN_PASSWORD                ${ADMIN_PASSWORD}"
echo "######################################################################"
