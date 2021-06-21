#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

CREDENTIAL_STORE_NAME="my_store"
CREDENTIAL_STORE_LOCATION="cred_stores/my_store.jceks"
CREDENTIAL_STORE_CLEAR_TEXT="1234qwer"
