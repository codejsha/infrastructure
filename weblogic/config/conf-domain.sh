#!/bin/bash

source ./env-base.sh

######################################################################

mkdir -p ${LOG_DIR}/domain
mkdir -p ${LOG_DIR}/dump

ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}
