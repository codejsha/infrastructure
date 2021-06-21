#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

HTTPD_HOME="${HTTPD_HOME}"

mkdir -p ${HTTPD_HOME}/conf/jk
/bin/cp -f mod_jk.conf uriworkermap.properties workers.properties ${HTTPD_HOME}/conf/jk
