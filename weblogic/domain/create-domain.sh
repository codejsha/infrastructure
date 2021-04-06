#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

ORACLE_HOME="${ORACLE_HOME}"   # for 14c, 12c
MW_HOME="${MW_HOME}"           # for 11g

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"

######################################################################

function create_domain_14c {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_domain.py
}

function create_domain_12c {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_domain.py
}

function create_domain_12cr1 {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_domain_12cr1.py
}

function create_domain_11g {
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_domain_11g.py
}

function create_domain {
    if [[ ${WEBLOGIC_VERSION} =~ ^14. ]]; then
        create_domain_14c
    elif [[ ${WEBLOGIC_VERSION} =~ ^12.2 ]]; then
        create_domain_12c
    elif [[ ${WEBLOGIC_VERSION} =~ ^12.1 ]]; then
        create_domain_12cr1
    elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
        create_domain_11g
    fi
}

######################################################################

create_domain
