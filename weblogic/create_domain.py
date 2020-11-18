#!/usr/bin/env python

oracle_home = os.environ['ORACLE_HOME']
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

print('[INFO] Set administration username and password')
cd('/Security/base_domain/User/weblogic')
cmo.setName(admin_username)
cmo.setPassword(admin_password)

print('[INFO] Set name, address and port for administration server')
cd('/Servers/AdminServer')
cmo.setName(admin_server_name)
cmo.setListenAddress(admin_server_listen_address)
cmo.setListenPort(int(admin_server_listen_port))
cmo.setWeblogicPluginEnabled(True)
cmo.setStagingMode('nostage')

print('[INFO] Create a domain')
cd('/')
writeDomain(domain_home)
closeTemplate()

exit()
