#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

CREDENTIAL_STORE_NAME="my_store"
CREDENTIAL_STORE_LOCATION="cred_stores/my_store.jceks"
CREDENTIAL_STORE_CLEAR_TEXT="1234qwer"
