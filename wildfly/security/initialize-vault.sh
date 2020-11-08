#!/usr/bin/bash

source ../env-base.sh
source ./env-vault.sh

if [ ! -f "${JBOSS_HOME}/vault/vault.keystore" ]; then
    echo "[INFO] The keystore is created."
    keytool \
        -genseckey \
        -alias vault \
        -storetype jceks \
        -keyalg AES \
        -keysize 128 \
        -storepass ${KEYSTORE_PASSWORD} \
        -keypass ${KEYSTORE_PASSWORD} \
        -validity 36500 \
        -keystore ${JBOSS_HOME}/vault/vault.keystore
else
    echo "[ERROR] The keystore is already exists!"
fi
