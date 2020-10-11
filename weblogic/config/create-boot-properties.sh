#!/usr/bin/bash

source ./env-base.sh

######################################################################

cat <<EOF > ${DOMAIN_HOME}/boot.properties
username=${ADMIN_USERNAME}
password=${ADMIN_PASSWORD}
EOF
