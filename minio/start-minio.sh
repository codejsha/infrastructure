#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

USERNAME="minio"
PASSWORD="minio123"
# PASSWORD="${PASSWORD}"

SERVER_NAME="minio"
export MINIO_ROOT_USER="${USERNAME}"
export MINIO_ROOT_PASSWORD="${PASSWORD}"

MINIO_DIR="/mnt/minio"
DATA_DIR="${MINIO_DIR}/data"
LOG_DIR="${MINIO_DIR}/logs"

sudo mkdir -p ${DATA_DIR}
sudo mkdir -p ${LOG_DIR}/backup
sudo chown -R $(id -un):$(id -gn) ${MINIO_DIR}

DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/backup/nohup.${SERVER_NAME}.${DATETIME}.out
fi

nohup minio server ${DATA_DIR} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
