#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-component.sh

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

### replace pattern with string
TEMP="\${ORACLE_HOME}"
VAR_DOMAIN_HOME="${DOMAIN_HOME/${ORACLE_HOME}/${TEMP}}"
TEMP="\${DOMAIN_NAME}"
VAR_DOMAIN_HOME="${VAR_DOMAIN_HOME/${DOMAIN_NAME}/${TEMP}}"

######################################################################

### dumpMetrics

cat <<EOF > ${DOMAIN_HOME}/scripts/get_dump_metrics.py
#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
component_name = os.environ['COMPONENT_NAME']
node_manager_listen_address = os.environ['NODE_MANAGER_LISTEN_ADDRESS']
node_manager_listen_port = int(os.environ['NODE_MANAGER_LISTEN_PORT'])
node_manager_username = os.environ['NODE_MANAGER_USERNAME']
node_manager_password = os.environ['NODE_MANAGER_PASSWORD']

nmConnect(node_manager_username, node_manager_password,
          node_manager_listen_address, node_manager_listen_port,
          domain_name)
dumpMetrics(servers=[component_name], servertype='OHS')

nmDisconnect()
exit()
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-dump-metrics-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_dump_metrics.py
EOF

######################################################################

### displayMetricTables

cat <<EOF > ${DOMAIN_HOME}/scripts/get_metrics.py
#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
component_name = os.environ['COMPONENT_NAME']
node_manager_listen_address = os.environ['NODE_MANAGER_LISTEN_ADDRESS']
node_manager_listen_port = int(os.environ['NODE_MANAGER_LISTEN_PORT'])
node_manager_username = os.environ['NODE_MANAGER_USERNAME']
node_manager_password = os.environ['NODE_MANAGER_PASSWORD']
metric_table_name = os.environ['METRIC_TABLE_NAME']

nmConnect(node_manager_username, node_manager_password,
          node_manager_listen_address, node_manager_listen_port,
          domain_name)

if metric_table_name == 'OHSWebLogic':
    displayMetricTables('OHSWebLogic', servers=[component_name], servertype='OHS')
elif metric_table_name == 'dms_cProcessInfo':
    displayMetricTables('dms_cProcessInfo', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_module':
    displayMetricTables('ohs_module', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_moduleSet':
    displayMetricTables('ohs_moduleSet', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_responses':
    displayMetricTables('ohs_responses', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_server':
    displayMetricTables('ohs_server', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_vhostSet':
    displayMetricTables('ohs_vhostSet', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_virtualHost':
    displayMetricTables('ohs_virtualHost', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_virtualHostAddr':
    displayMetricTables('ohs_virtualHostAddr', servers=[component_name], servertype='OHS')
elif metric_table_name == 'ohs_virtualHostAddrs':
    displayMetricTables('ohs_virtualHostAddrs', servers=[component_name], servertype='OHS')
elif metric_table_name == 'system':
    displayMetricTables('system', servers=[component_name], servertype='OHS')
elif metric_table_name == 'system_host':
    displayMetricTables('system_host', servers=[component_name], servertype='OHS')
elif metric_table_name == 'system_process':
    displayMetricTables('system_process', servers=[component_name], servertype='OHS')
else:
    pass

nmDisconnect()
exit()
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-plugin-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="OHSWebLogic"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-process-info-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="dms_cProcessInfo"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-module-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_module"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-moduleset-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_moduleSet"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-response-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_responses"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-server-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_server"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-vhostset-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_vhostSet"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-vhost-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_virtualHost"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-vhostaddr-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_virtualHostAddr"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-vhostaddrs-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="ohs_virtualHostAddrs"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-system-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="system"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-system-host-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="system_host"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-system-process-${COMPONENT_NAME}.sh
#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

METRIC_TABLE_NAME="system_process"

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"
NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"
export METRIC_TABLE_NAME DOMAIN_NAME COMPONENT_NAME
export NODE_MANAGER_LISTEN_ADDRESS NODE_MANAGER_LISTEN_PORT NODE_MANAGER_USERNAME NODE_MANAGER_PASSWORD

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get_metrics.py
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/get-dump-metrics-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-plugin-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-process-info-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-module-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-moduleset-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-response-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-server-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-vhostset-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-vhost-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-vhostaddr-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-vhostaddrs-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-system-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-system-host-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-system-process-${COMPONENT_NAME}.sh
