#!/usr/bin/bash

source ./env-base.sh

######################################################################

mkdir -p ${LOG_HOME}/domain
ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}
