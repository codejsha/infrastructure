#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

######################################################################

cat <<EOF > ${DOMAIN_HOME}/boot.properties
username=${ADMIN_USERNAME}
password=${ADMIN_PASSWORD}
EOF
