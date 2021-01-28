#!/usr/bin/env python

oracle_home = '/usr/local/ohs'
domain_name = 'base_domain'
domain_home = oracle_home + '/user_projects/domains/' + domain_name
node_manager_name = 'localmachine'
component_name = 'ohs1'
component_admin_listen_address = '127.0.0.1'
component_admin_listen_port = '9999'
component_listen_address = ''
component_listen_port = '7777'
component_ssl_listen_port = '4443'

######################################################################

readDomain(domain_home)

cd('/')
create(component_name, 'SystemComponent')
cd('/SystemComponent/' + component_name)
cmo.setComponentType('OHS')
set('Machine', node_manager_name)

cd('/OHS/' + component_name)
cmo.setAdminHost(component_admin_listen_address)
cmo.setAdminPort(component_admin_listen_port)
cmo.setListenAddress(component_listen_address)
cmo.setListenPort(component_listen_port)
cmo.setSSLListenPort(component_ssl_listen_port)

updateDomain()
closeDomain()

exit()
