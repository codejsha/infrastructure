#!/bin/bash

### required package:
### sudo yum install -y links

HTTPD_HOME="/usr/local/httpd"

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-server-status.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

PORT="80"

links -dump http://127.0.0.1:\${PORT}/server-status
EOF

######################################################################

chmod 750 ${HTTPD_HOME}/get-server-status.sh
