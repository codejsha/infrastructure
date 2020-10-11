#!/usr/bin/bash

source ./env-base.sh

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh set_domain_cookie_name.py
elif [ "${MAJOR_VERSION}" == "12c" ] && [ "${MAJOR_VERSION}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_domain_cookie_name.py
fi
