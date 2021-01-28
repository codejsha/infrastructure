#!/usr/bin/env python

oracle_home = '/usr/local/ohs'
domain_name = 'base_domain'
domain_home = oracle_home + '/user_projects/domains/' + domain_name
node_manager_name = 'localmachine'
node_manager_listen_address = 'localhost'
node_manager_listen_port = '5556'
node_manager_username = 'ohs'
node_manager_password = 'welcome1'

######################################################################

readTemplate(oracle_home + '/ohs/common/templates/wls/ohs_standalone_template.jar')

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
