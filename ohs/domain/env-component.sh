#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

export COMPONENT_NAME="ohs1"
export COMPONENT_ADMIN_LISTEN_ADDRESS="127.0.0.1"
export COMPONENT_ADMIN_LISTEN_PORT="9999"
export COMPONENT_LISTEN_ADDRESS=""
export COMPONENT_LISTEN_PORT="7777"
export COMPONENT_SSL_LISTEN_PORT="4443"
