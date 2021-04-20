#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

DATETIME="$(date +'%Y%m%d_%H%M%S')"
NEW_USERNAME="${1:-"weblogic"}"
NEW_PASSWORD="${2:-"welcome1"}"

######################################################################

mv ${DOMAIN_HOME}/config/nodemanager/nm_password.properties ${DOMAIN_HOME}/config/nodemanager/nm_password.properties.${DATETIME}
cat <<EOF > ${DOMAIN_HOME}/config/nodemanager/nm_password.properties
username=${NEW_USERNAME}
password=${NEW_PASSWORD}
EOF

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh change_nodemgr_password.py
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh change_nodemgr_password.py
fi
