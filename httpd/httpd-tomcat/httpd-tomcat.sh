#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

HTTPD_HOME="/usr/local/httpd"

/bin/cp -f mod-jk.conf uriworkermap.properties workers.properties ${HTTPD_HOME}
