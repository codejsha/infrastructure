#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

IPLANET_HOME="/usr/local/iplanet"
IPLANET_HOST="test.example.com"
IPLANET_SSL_PORT="8989"
IPLANET_USER="admin"
IPLANET_PASSWORD="welcome1"

IPLANET_SERVER="server1"
HTTP_LISTENER_NAME="http-listener-2"
HTTP_LISTENER_IP_ADDRESS="*"
HTTP_LISTENER_PORT="80"
IPLANET_VSERVER="vserver1"

cat <<EOF > ${IPLANET_HOME}/pswd-file
wadm_password=${IPLANET_PASSWORD}
EOF

${IPLANET_HOME}/bin/wadm pull-config \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --config="${IPLANET_SERVER}" \
    "${IPLANET_HOST}"

${IPLANET_HOME}/bin/wadm create-http-listener \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --enabled="true" \
    --ip="${HTTP_LISTENER_IP_ADDRESS}" \
    --listener-port="${HTTP_LISTENER_PORT}" \
    --default-virtual-server-name="${IPLANET_VSERVER}" \
    --server-name="${IPLANET_SERVER}" \
    --config="${IPLANET_SERVER}" \
    "${HTTP_LISTENER_NAME}"

${IPLANET_HOME}/bin/wadm deploy-config \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    "${IPLANET_SERVER}"
