#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

######################################################################

cat <<EOF > ${DOMAIN_HOME}/boot.properties
username=${ADMIN_USERNAME}
password=${ADMIN_PASSWORD}
EOF
