#!/bin/bash

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
