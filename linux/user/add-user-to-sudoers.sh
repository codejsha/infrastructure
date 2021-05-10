#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

USER="prouser"

cat <<EOF > /etc/sudoers.d/${USER}
${USER} ALL=(ALL) NOPASSWD:ALL
EOF
