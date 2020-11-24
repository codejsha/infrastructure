#!/bin/bash

source ./env-base.sh

######################################################################

mkdir -p ${LOG_DIR}/Domain
ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}
