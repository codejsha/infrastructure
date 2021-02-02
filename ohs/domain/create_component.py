#!/usr/bin/env python

oracle_home = os.environ['ORACLE_HOME']
domain_name = os.environ['DOMAIN_NAME']
domain_home = os.environ['DOMAIN_HOME']
node_manager_name = os.environ['NODE_MANAGER_NAME']
component_name = os.environ['COMPONENT_NAME']
component_admin_listen_address = os.environ['COMPONENT_ADMIN_LISTEN_ADDRESS']
component_admin_listen_port = os.environ['COMPONENT_ADMIN_LISTEN_PORT']
component_listen_address = os.environ['COMPONENT_LISTEN_ADDRESS']
component_listen_port = os.environ['COMPONENT_LISTEN_PORT']
component_ssl_listen_port = os.environ['COMPONENT_SSL_LISTEN_PORT']

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
