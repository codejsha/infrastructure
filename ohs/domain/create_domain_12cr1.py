#!/usr/bin/env python

oracle_home = os.environ['ORACLE_HOME']
domain_name = os.environ['DOMAIN_NAME']
domain_home = os.environ['DOMAIN_HOME']
node_manager_name = os.environ['NODE_MANAGER_NAME']
node_manager_listen_address = os.environ['NODE_MANAGER_LISTEN_ADDRESS']
node_manager_listen_port = os.environ['NODE_MANAGER_LISTEN_PORT']
node_manager_username = os.environ['NODE_MANAGER_USERNAME']
node_manager_password = os.environ['NODE_MANAGER_PASSWORD']

######################################################################

readTemplate(oracle_home + '/ohs/common/templates/wls/ohs_standalone_template_12.1.3.jar')

cd('/')
create(domain_name, 'SecurityConfiguration')
cd('/SecurityConfiguration/base_domain')
set('NodeManagerUsername', node_manager_username)
set('NodeManagerPasswordEncrypted', node_manager_password)
setOption('NodeManagerType', 'PerDomainNodeManager')

cd('/')
create(node_manager_name, 'Machine')
cd('/Machines/' + node_manager_name)
create(node_manager_name, 'NodeManager')
cd('/Machines/' + node_manager_name + '/NodeManager/' + node_manager_name)
cmo.setListenAddress(node_manager_listen_address)
cmo.setListenPort(int(node_manager_listen_port))

cd('/')
writeDomain(domain_home)
closeTemplate()

exit()
