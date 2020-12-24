#!/bin/bash

source ./env-base.sh

CONNECTION_FILTER="${CONNECTION_FILTER}, 192.168.137.0/24 test.example.com 7001 allow"
CONNECTION_FILTER="${CONNECTION_FILTER}, 0.0.0.0/0 * * deny"
export CONNECTION_FILTER

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh set_domain_connection_filter.py
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_domain_connection_filter.py
fi
