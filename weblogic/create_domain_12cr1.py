#!/usr/bin/env python

oracle_home = '/usr/local/weblogic'
domain_home = oracle_home + '/user_projects/domains/base_domain'
admin_server_name = 'AdminServer'
admin_server_listen_address = 'test.example.com'
admin_server_listen_port = '7001'
admin_username = 'weblogic'
admin_password = 'welcome1'

######################################################################

print('Read the WebLogic domain template')
readTemplate(oracle_home + '/wlserver/common/templates/wls/wls.jar')
setOption('ServerStartMode', 'prod')

print('Set administration username and password')
cd('/Security/base_domain/User/weblogic')
cmo.setName(admin_username)
cmo.setPassword(admin_password)

print('Set name, address and port for administration server')
cd('/Servers/AdminServer')
cmo.setName(admin_server_name)
cmo.setListenAddress(admin_server_listen_address)
cmo.setListenPort(int(admin_server_listen_port))
cmo.setWeblogicPluginEnabled(True)
cmo.setStagingMode('nostage')

print('Create a domain')
cd('/')
writeDomain(domain_home)
closeTemplate()

exit()
