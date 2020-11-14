#!/usr/bin/bash

### required package:
### sudo yum install -y links

HTTPD_HOME="/usr/local/httpd"

cat <<EOF > ${HTTPD_HOME}/start-httpd.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -k start
EOF

cat <<EOF > ${HTTPD_HOME}/restart-httpd.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -k restart
EOF

cat <<EOF > ${HTTPD_HOME}/stop-httpd.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -k stop
EOF

cat <<EOF > ${HTTPD_HOME}/check-config.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -t
EOF

cat <<EOF > ${HTTPD_HOME}/get-version.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"

\${HTTPD_HOME}/bin/apachectl -v
EOF

cat <<EOF > ${HTTPD_HOME}/get-compile-settings.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"

\${HTTPD_HOME}/bin/apachectl -V
EOF

cat <<EOF > ${HTTPD_HOME}/get-vhosts-settings.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -t -D DUMP_VHOSTS
EOF

cat <<EOF > ${HTTPD_HOME}/get-run-settings.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -D DUMP_RUN_CFG
EOF

cat <<EOF > ${HTTPD_HOME}/get-settings.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -S
# \${HTTPD_HOME}/bin/apachectl -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

cat <<EOF > ${HTTPD_HOME}/get-load-modules.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -M
# \${HTTPD_HOME}/bin/apachectl -t -D DUMP_MODULES
EOF

cat <<EOF > ${HTTPD_HOME}/get-include-files.sh
#!/usr/bin/bash

HTTPD_HOME="${HTTPD_HOME}"
# export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"

\${HTTPD_HOME}/bin/apachectl -t -D DUMP_INCLUDES
EOF

cat <<EOF > ${HTTPD_HOME}/get-server-status.sh
#!/usr/bin/bash

PORT="80"

links -dump http://127.0.0.1:\${PORT}/server-status
EOF

chmod 750 ${HTTPD_HOME}/start-httpd.sh
chmod 750 ${HTTPD_HOME}/restart-httpd.sh
chmod 750 ${HTTPD_HOME}/stop-httpd.sh
chmod 750 ${HTTPD_HOME}/check-config.sh
chmod 750 ${HTTPD_HOME}/get-version.sh
chmod 750 ${HTTPD_HOME}/get-compile-settings.sh
chmod 750 ${HTTPD_HOME}/get-vhosts-settings.sh
chmod 750 ${HTTPD_HOME}/get-run-settings.sh
chmod 750 ${HTTPD_HOME}/get-settings.sh
chmod 750 ${HTTPD_HOME}/get-load-modules.sh
chmod 750 ${HTTPD_HOME}/get-include-files.sh
chmod 750 ${HTTPD_HOME}/get-server-status.sh
