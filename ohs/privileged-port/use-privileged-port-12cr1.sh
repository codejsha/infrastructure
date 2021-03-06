#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

NORMAL_USERNAME="prouser"

USERNAME="$(id --user --name)"
if [ "${USERNAME}" != "root" ]; then
    echo "[ERROR] Please run as root!"
    exit 1
fi

su - ${NORMAL_USERNAME} -c "echo `id -ng`: bind  > /tmp/cap.ora"

chown root ${ORACLE_HOME}/oracle_common/bin/hasbind
chmod 4755 ${ORACLE_HOME}/oracle_common/bin/hasbind

if [ -f "/etc/cap.ora" ]; then
    cat /tmp/cap.ora >> /etc/cap.ora
else
    cp /tmp/cap.ora /etc/cap.ora
fi

chmod 644 /etc/cap.ora
chown root /etc/cap.ora

rm /tmp/cap.ora
