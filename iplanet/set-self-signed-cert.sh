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
HTTP_LISTENER1_NAME="http-listener-1"
HTTP_LISTENER2_NAME="http-listener-2"
HTTP_LISTENER2_IP_ADDRESS="*"
HTTP_LISTENER2_SSL_PORT="443"
CERT_NAME="cert1"
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
    --ip="${HTTP_LISTENER2_IP_ADDRESS}" \
    --listener-port="${HTTP_LISTENER2_SSL_PORT}" \
    --default-virtual-server-name="${IPLANET_VSERVER}" \
    --server-name="${IPLANET_SERVER}" \
    --config="${IPLANET_SERVER}" \
    "${HTTP_LISTENER2_NAME}"

${IPLANET_HOME}/bin/wadm create-selfsigned-cert \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --port="${IPLANET_SSL_PORT}" \
    --token="internal" \
    --org-unit="devteam" \
    --locality="Gangnam" \
    --state="Seoul" \
    --validity="10" \
    --org="dev" \
    --country="KR" \
    --server-name="${IPLANET_SERVER}" \
    --config="${IPLANET_SERVER}" \
    --nickname="${CERT_NAME}"

${IPLANET_HOME}/bin/wadm set-ssl-prop \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --http-listener="${HTTP_LISTENER2_NAME}" \
    --config="${IPLANET_SERVER}" \
    enabled="true" \
    server-cert-nickname="${CERT_NAME}"

${IPLANET_HOME}/bin/wadm set-virtual-server-prop \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    --vs="${IPLANET_VSERVER}" \
    --config="${IPLANET_SERVER}" \
    http-listener-name="${HTTP_LISTENER1_NAME},${HTTP_LISTENER2_NAME}"

${IPLANET_HOME}/bin/wadm deploy-config \
    --user="${IPLANET_USER}" \
    --password-file="${IPLANET_HOME}/pswd-file" \
    --host="${IPLANET_HOST}" \
    --port="${IPLANET_SSL_PORT}" \
    --ssl="true" \
    --rcfile="null" \
    --no-prompt \
    "${IPLANET_SERVER}"
