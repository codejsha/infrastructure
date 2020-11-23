#!/usr/bin/bash

source ./env-base.sh

JBOSS_BASE_DIR="${JBOSS_BASE_DIR}"

grep -v "^#" ${JBOSS_BASE_DIR}/configuration/mgmt-users.properties
