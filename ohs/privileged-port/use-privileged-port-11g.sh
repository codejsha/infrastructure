#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base-11g.sh

USERNAME="$(id --user --name)"
if [ "${USERNAME}" != "root" ]; then
    echo "[ERROR] Please run as root!"
    exit 1
fi

cd ${ORACLE_HOME}/ohs/bin
chown root .apachectl
chmod 6750 .apachectl

### Configure the User and Group directive in httpd.conf.
# User prouser
# Group progroup
