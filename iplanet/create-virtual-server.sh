#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

IPLANET_HOME="/usr/local/iplanet"
IPLANET_HOST="test.example.com"
IPLANET_SSL_PORT="8989"
IPLANET_USER="admin"
IPLANET_PASSWORD="welcome1"

IPLANET_SERVER="server1"
HTTP_LISTENER_NAME="http-listener-1"
IPLANET_VSERVER="vserver1"
IPLANET_VSERVER_DOCROOT="${IPLANET_HOME}/https-${IPLANET_SERVER}/docs"

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

${IPLANET_HOME}/bin/wadm create-virtual-server \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --http-listener-name="${HTTP_LISTENER_NAME}" \
    --host-pattern="${IPLANET_SERVER}" \
    --document-root="${IPLANET_VSERVER_DOCROOT}" \
    --config="${IPLANET_SERVER}" \
    "${IPLANET_VSERVER}"

${IPLANET_HOME}/bin/wadm deploy-config \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    "${IPLANET_SERVER}"
