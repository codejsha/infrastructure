#!/usr/bin/bash

source ./env-base.sh

PASSWORD="<PASSWORD>"

${JBOSS_HOME}/bin/add-user.sh --user "admin" --password "${PASSWORD}" -sc ${JBOSS_BASE_DIR}/configuration
# ${JBOSS_HOME}/bin/add-user.sh --user "developer" --password "${PASSWORD}" -sc ${JBOSS_BASE_DIR}/configuration
