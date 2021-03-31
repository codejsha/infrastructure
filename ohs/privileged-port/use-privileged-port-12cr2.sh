#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

USERNAME="$(id --user --name)"
if [ "${USERNAME}" != "root" ]; then
    echo "[ERROR] Please run as root!"
    exit 1
fi

chown root ${ORACLE_HOME}/ohs/bin/launch
chmod 4750 ${ORACLE_HOME}/ohs/bin/launch

### Configure the User and Group directive in httpd.conf.
# User prouser
# Group progroup
