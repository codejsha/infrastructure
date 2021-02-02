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
