#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### requirement:
### sudo yum install -y links

source ../env-base.sh

DOMAIN_HOME="${DOMAIN_HOME}"

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-server-status.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o errexit
set -o errtrace
set -o xtrace

LISTEN_ADDRESS="127.0.0.1"
# LISTEN_ADDRESS="test.example.com"
LISTEN_PORT="80"

links -dump http://\${LISTEN_ADDRESS}:\${LISTEN_PORT}/server-status
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/get-server-status.sh
