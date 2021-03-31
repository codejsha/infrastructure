#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### requirement:
### sudo yum install -y links

source ./env-base-11g.sh

INSTANCE_HOME="${INSTANCE_HOME}"

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-server-status.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

LISTEN_ADDRESS="127.0.0.1"
# LISTEN_ADDRESS="test.example.com"
LISTEN_PORT="80"

links -dump http://\${LISTEN_ADDRESS}:\${LISTEN_PORT}/server-status
EOF

######################################################################

chmod 750 ${INSTANCE_HOME}/get-server-status.sh
