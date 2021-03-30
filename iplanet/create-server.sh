#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

IPLANET_HOME="/usr/local/iplanet"
IPLANET_HOST="test.example.com"
IPLANET_SSL_PORT="8989"
IPLANET_USER="admin"
IPLANET_PASSWORD="welcome1"

IPLANET_SERVER="server1"
HTTP_LISTENER_IP_ADDRESS="*"
HTTP_LISTENER_PORT="80"
IPLANET_VSERVER_DOCROOT="${IPLANET_HOME}/https-${IPLANET_SERVER}/docs"

cat <<EOF > ${IPLANET_HOME}/pswd-file
wadm_password=${IPLANET_PASSWORD}
EOF

${IPLANET_HOME}/bin/wadm create-config \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --platform="64" \
    --document-root="${IPLANET_VSERVER_DOCROOT}" \
    --jdk-home="\${WS_INSTALL_ROOT}/jdk" \
    --server-user="webservd" \
    --ip="${HTTP_LISTENER_IP_ADDRESS}" \
    --http-port="${HTTP_LISTENER_PORT}" \
    --server-name="${IPLANET_SERVER}" \
    "${IPLANET_SERVER}"

${IPLANET_HOME}/bin/wadm create-instance \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --config="${IPLANET_SERVER}" \
    "${IPLANET_HOST}"
