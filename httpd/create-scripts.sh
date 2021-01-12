#!/bin/bash

HTTPD_HOME="/usr/local/httpd"

######################################################################

cat <<EOF > ${HTTPD_HOME}/start-httpd.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -k start
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/restart-httpd.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -k restart
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/stop-httpd.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -k stop
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/check-config.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -t
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-compile-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -V
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-include-files.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -t -D DUMP_INCLUDES
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-load-modules.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

# \${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -M
\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -t -D DUMP_MODULES
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-run-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

# \${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -S
\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-version.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -v
EOF

######################################################################

cat <<EOF > ${HTTPD_HOME}/get-vhosts-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

HTTPD_HOME="${HTTPD_HOME}"
# LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${HTTPD_HOME}/modules/weblogic-plugin/lib"
# export LD_LIBRARY_PATH

\${HTTPD_HOME}/bin/apachectl -d \${HTTPD_HOME} -f \${HTTPD_HOME}/conf/httpd.conf -t -D DUMP_VHOSTS
EOF

######################################################################

chmod 750 ${HTTPD_HOME}/start-httpd.sh
chmod 750 ${HTTPD_HOME}/restart-httpd.sh
chmod 750 ${HTTPD_HOME}/stop-httpd.sh
chmod 750 ${HTTPD_HOME}/check-config.sh
chmod 750 ${HTTPD_HOME}/get-compile-settings.sh
chmod 750 ${HTTPD_HOME}/get-include-files.sh
chmod 750 ${HTTPD_HOME}/get-load-modules.sh
chmod 750 ${HTTPD_HOME}/get-run-settings.sh
chmod 750 ${HTTPD_HOME}/get-settings.sh
chmod 750 ${HTTPD_HOME}/get-version.sh
chmod 750 ${HTTPD_HOME}/get-vhosts-settings.sh
