#!/bin/bash

### required package:
### sudo yum install -y links

source ./env-base-11g.sh

INSTANCE_HOME="${INSTANCE_HOME}"

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-server-status.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

# HOSTNAME_IP_ADDRESS="$(hostname -i)"
LISTEN_ADDRESS="127.0.0.1"
LISTEN_PORT="80"

links -dump http://\${LISTEN_ADDRESS}:\${LISTEN_PORT}/server-status
EOF

######################################################################

chmod 750 ${INSTANCE_HOME}/get-server-status.sh