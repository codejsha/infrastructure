#!/usr/bin/env python

mw_home = os.environ['MW_HOME']
oracle_home = mw_home
domain_home = os.environ['DOMAIN_HOME']
admin_server_name = os.environ['ADMIN_SERVER_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

######################################################################

print('[INFO] Select the WebLogic domain template')
selectTemplate('Basic WebLogic Server Domain')
loadTemplates()
setOption('ServerStartMode', 'prod')

print('[INFO] Set the username and password for administration server')
cd('/Security/base_domain/User/weblogic')
set('Name', admin_username)
cmo.setPassword(admin_password)

print('[INFO] Configure the administration server')
cd('/Servers/AdminServer')
set('Name', admin_server_name)
set('ListenAddress', admin_server_listen_address)
set('ListenPort', int(admin_server_listen_port))
set('WeblogicPluginEnabled', True)
set('StagingMode', 'nostage')

print('[INFO] Create a domain')
cd('/')
writeDomain(domain_home)
closeTemplate()

exit()
