#!/usr/bin/bash

source ./env-base.sh

######################################################################

cat << EOF > ${DOMAIN_HOME}/scripts/encrypt-password-script.sh
#!/usr/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

JAVA_HOME="${JAVA_HOME}"
WEBLOGIC_HOME="${WEBLOGIC_HOME}"
PLAINTEXT_PASSWORD="\${1}"

ENCRYPTED_PASSWORD=\$(\${JAVA_HOME}/bin/java -classpath \${WEBLOGIC_HOME}/server/lib/weblogic.jar weblogic.security.Encrypt \${PLAINTEXT_PASSWORD})
echo ${ENCRYPTED_PASSWORD}
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/encrypt-password-script.sh
