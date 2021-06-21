#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/change-password.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

JAVA_HOME="${JAVA_HOME}"
WL_HOME="${WL_HOME}"
DOMAIN_HOME="${DOMAIN_HOME}"
DATETIME="\$(date +'%Y%m%d_%H%M%S')"
NEW_USERNAME="\${1:-"weblogic"}"
NEW_PASSWORD="\${2:-"welcome1"}"

mv \${DOMAIN_HOME}/servers/AdminServer/data \${DOMAIN_HOME}/servers/AdminServer/data.\${DATETIME}
mv \${DOMAIN_HOME}/security/DefaultAuthenticatorInit.ldift \${DOMAIN_HOME}/security/DefaultAuthenticatorInit.ldift.\${DATETIME}
mv \${DOMAIN_HOME}/boot.properties \${DOMAIN_HOME}/boot.properties.\${DATETIME}

\${JAVA_HOME}/bin/java -classpath \${WL_HOME}/server/lib/weblogic.jar weblogic.security.utils.AdminAccount \${NEW_USERNAME} \${NEW_PASSWORD} \${DOMAIN_HOME}/security

cat <<EOF > \${DOMAIN_HOME}/boot.properties
username=\${NEW_USERNAME}
password=\${NEW_PASSWORD}
EOF
echo EOF >> ${DOMAIN_HOME}/scripts/change-password.sh

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/change-password.sh
