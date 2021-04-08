#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/encrypt-password.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

JAVA_HOME="${JAVA_HOME}"
WL_HOME="${WL_HOME}"
PLAINTEXT_PASSWORD="\${1}"

ENCRYPTED_PASSWORD="\$(\${JAVA_HOME}/bin/java -classpath \${WL_HOME}/server/lib/weblogic.jar weblogic.security.Encrypt \${PLAINTEXT_PASSWORD})"
echo \${ENCRYPTED_PASSWORD}
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/encrypt-password.sh
