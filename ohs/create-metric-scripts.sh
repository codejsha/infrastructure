#!/bin/bash

source ./env-base.sh
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

### displayMetricTables

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics.py
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

cat <<EOF > ${DOMAIN_HOME}/scripts/get-metrics-${COMPONENT_NAME}.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

export METRIC_TABLE_NAME="${1}"

export ORACLE_HOME="${ORACLE_HOME}"
export DOMAIN_NAME="${DOMAIN_NAME}"
export COMPONENT_NAME="${COMPONENT_NAME}"
export NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
export NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
export NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
export NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get-metrics.py
EOF

######################################################################

### dumpMetrics

cat <<EOF > ${DOMAIN_HOME}/scripts/get-dump-metrics.py
#!/usr/bin/env python
export PS4="\e[33;1m+ \e[0m"; set -x

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
export PS4="\e[33;1m+ \e[0m"; set -x

export ORACLE_HOME="${ORACLE_HOME}"
export DOMAIN_NAME="${DOMAIN_NAME}"
export COMPONENT_NAME="${COMPONENT_NAME}"
export NODE_MANAGER_LISTEN_ADDRESS="${NODE_MANAGER_LISTEN_ADDRESS}"
export NODE_MANAGER_LISTEN_PORT="${NODE_MANAGER_LISTEN_PORT}"
export NODE_MANAGER_USERNAME="${NODE_MANAGER_USERNAME}"
export NODE_MANAGER_PASSWORD="${NODE_MANAGER_PASSWORD}"

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/get-dump-metrics.py
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/get-metrics-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/scripts/get-dump-metrics-${COMPONENT_NAME}.sh

######################################################################
