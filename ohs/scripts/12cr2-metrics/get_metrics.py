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
