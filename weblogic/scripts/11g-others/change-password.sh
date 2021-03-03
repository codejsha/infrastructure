#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

JAVA_HOME="/usr/java/current"
WL_HOME="/usr/local/weblogic/wlserver_10.3"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
GET_DATE="$(date +'%Y%m%d_%H%M%S')"
NEW_USERNAME="${1:-"weblogic"}"
NEW_PASSWORD="${2:-"welcome1"}"

mv ${DOMAIN_HOME}/servers/AdminServer/data ${DOMAIN_HOME}/servers/AdminServer/data.${GET_DATE}
mv ${DOMAIN_HOME}/security/DefaultAuthenticatorInit.ldift ${DOMAIN_HOME}/security/DefaultAuthenticatorInit.ldift.${GET_DATE}
${JAVA_HOME}/bin/java -classpath ${WL_HOME}/server/lib/weblogic.jar weblogic.security.utils.AdminAccount ${NEW_USERNAME} ${NEW_PASSWORD} ${DOMAIN_HOME}/security

mv ${DOMAIN_HOME}/boot.properties ${DOMAIN_HOME}/boot.properties.${GET_DATE}
cat <<EOF > ${DOMAIN_HOME}/boot.properties
username=${NEW_USERNAME}
password=${NEW_PASSWORD}
EOF
