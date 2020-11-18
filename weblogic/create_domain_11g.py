#!/usr/bin/env python

mw_home = '/usr/local/weblogic'
domain_home = mw_home + '/user_projects/domains/base_domain'
admin_server_name = 'AdminServer'
admin_server_listen_address = 'test.example.com'
admin_server_listen_port = '7001'
admin_username = 'weblogic'
admin_password = 'welcome1'

######################################################################

print('[INFO] Read the WebLogic domain template')
readTemplate(mw_home + '/wlserver_10.3/common/templates/domains/wls.jar')
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
