#!/usr/bin/bash

source ./env-base.sh

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat << EOF > ${DOMAIN_HOME}/scripts/change-password.sh
#!/usr/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

JAVA_HOME="${JAVA_HOME}"
DOMAIN_HOME="${DOMAIN_HOME}"
WEBLOGIC_HOME="${WEBLOGIC_HOME}"
GET_DATE="\$(date +'%Y%m%d_%H%M%S')"
NEW_USERNAME="\${1:-"weblogic"}"
NEW_PASSWORD="\${2:-"welcome1"}"

mv \${DOMAIN_HOME}/servers/AdminServer/data \${DOMAIN_HOME}/servers/AdminServer/data.\${GET_DATE}
mv \${DOMAIN_HOME}/security/DefaultAuthenticatorInit.ldift \${DOMAIN_HOME}/security/DefaultAuthenticatorInit.ldift.\${GET_DATE}
\${JAVA_HOME}/bin/java -classpath \${WEBLOGIC_HOME}/server/lib/weblogic.jar weblogic.security.utils.AdminAccount \${NEW_USERNAME} \${NEW_PASSWORD} \${DOMAIN_HOME}/security

mv \${DOMAIN_HOME}/boot.properties \${DOMAIN_HOME}/boot.properties.\${GET_DATE}
cat <<EOF > \${DOMAIN_HOME}/boot.properties
username=\${NEW_USERNAME}
password=\${NEW_PASSWORD}
EOF
echo EOF >> ${DOMAIN_HOME}/scripts/change-password.sh

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/change-password.sh
