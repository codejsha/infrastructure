#!/usr/bin/bash

source ./env-base.sh

grep -v "^#" ${JBOSS_BASE_DIR}/configuration/mgmt-users.properties
