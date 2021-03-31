#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

INSTALL_FILE_DIR="/mnt/share/redhat-codeready-containers"
INSTALL_FILE="crc-linux-amd64.tar.xz"
SECRET_FILE="pull-secret.txt"

/bin/cp -f ${INSTALL_FILE_DIR}/${INSTALL_FILE} ~
/bin/cp -f ${INSTALL_FILE_DIR}/${SECRET_FILE} ~
tar -xf ~/${INSTALL_FILE}

mv crc-linux-*-amd64 crc-linux
cd crc-linux

./crc version
./crc setup
./crc start --pull-secret-file ~/pull-secret.txt

echo "export PATH=\"\${PATH}:\${HOME}/.crc/bin/oc\"" >> ~/.bashrc
echo "export PATH=\"\${PATH}:\${HOME}/crc-linux\"" >> ~/.bashrc
echo "eval \$(crc oc-env)" >> ~/.bashrc
