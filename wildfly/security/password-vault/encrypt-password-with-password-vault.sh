#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh
source ./env-password-vault.sh

JBOSS_HOME="${JBOSS_HOME}"
KEYSTORE_PASSWORD="${KEYSTORE_PASSWORD}"

PASSWORD="${1}"
VAULT_BLOCK="datasource"
SALT="1234abcd"

### vault.sh parameters:
### --keystore KEYSTORE_URL
### --keystore-password KEYSTORE_PASSWORD
### --salt SALT
### --alias KEYSTORE_ALIAS
### --iteration ITERATION_COUNT
### --enc-dir ENC_FILE_DIR (Directory to store encrypted files)
### --vault-block VAULT_BLOCK
### --attribute ATTRIBUTE
### --sec-attr SEC-ATTR
bash ${JBOSS_HOME}/bin/vault.sh \
    --keystore ${JBOSS_HOME}/vault/vault.keystore \
    --keystore-password ${KEYSTORE_PASSWORD} \
    --salt ${SALT} \
    --alias vault \
    --iteration 120 \
    --enc-dir ${JBOSS_HOME}/vault/ \
    --vault-block ${VAULT_BLOCK} \
    --attribute password \
    --sec-attr ${PASSWORD}

### Result format
### ${VAULT::VAULT_BLOCK::ATTRIBUTE_NAME::MASKED_STRING}

### Run vault configuration commands in CLI (jboss-cli)
### For standalone mode: // ...
### For domain mode: // ...
