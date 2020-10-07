#!/usr/bin/bash

### required package:
### sudo yum install -y links

SERVER_ROOT="/usr/local/httpd"

cat <<EOF > ${SERVER_ROOT}/start-httpd.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -k start
EOF

cat <<EOF > ${SERVER_ROOT}/restart-httpd.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -k restart
EOF

cat <<EOF > ${SERVER_ROOT}/stop-httpd.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -k stop
EOF

cat <<EOF > ${SERVER_ROOT}/check-config.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -t
EOF

cat <<EOF > ${SERVER_ROOT}/get-version.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -v
EOF

cat <<EOF > ${SERVER_ROOT}/get-compile-settings.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -V
EOF

cat <<EOF > ${SERVER_ROOT}/get-dump-vhosts.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -t -D DUMP_VHOSTS
EOF

cat <<EOF > ${SERVER_ROOT}/get-dump-run-cfg.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -D DUMP_RUN_CFG
EOF

cat <<EOF > ${SERVER_ROOT}/get-dump-settings.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -S
# \${SERVER_ROOT}/bin/apachectl -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

cat <<EOF > ${SERVER_ROOT}/get-dump-modules.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -M
# \${SERVER_ROOT}/bin/apachectl -t -D DUMP_MODULES
EOF

cat <<EOF > ${SERVER_ROOT}/get-dump-includes.sh
#!/usr/bin/bash

SERVER_ROOT="${SERVER_ROOT}"

\${SERVER_ROOT}/bin/apachectl -t -D DUMP_INCLUDES
EOF

cat <<EOF > ${SERVER_ROOT}/get-links-dump.sh
#!/usr/bin/bash

PORT="80"

links -dump http://127.0.0.1:\${PORT}/server-status
EOF

chmod 750 ${SERVER_ROOT}/start-httpd.sh
chmod 750 ${SERVER_ROOT}/restart-httpd.sh
chmod 750 ${SERVER_ROOT}/stop-httpd.sh
chmod 750 ${SERVER_ROOT}/check-config.sh
chmod 750 ${SERVER_ROOT}/get-version.sh
chmod 750 ${SERVER_ROOT}/get-compile-settings.sh
chmod 750 ${SERVER_ROOT}/get-dump-vhosts.sh
chmod 750 ${SERVER_ROOT}/get-dump-run-cfg.sh
chmod 750 ${SERVER_ROOT}/get-dump-settings.sh
chmod 750 ${SERVER_ROOT}/get-dump-modules.sh
chmod 750 ${SERVER_ROOT}/get-dump-includes.sh
chmod 750 ${SERVER_ROOT}/get-links-dump.sh
