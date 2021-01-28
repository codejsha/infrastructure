#!/usr/bin/env python

domain_home = os.environ['DOMAIN_HOME']
admin_server_url = os.environ['ADMIN_SERVER_URL']
admin_server_name = os.environ['ADMIN_SERVER_NAME']

######################################################################

connect(userConfigFile=domain_home + '/security/WebLogicConfig.properties',
        userKeyFile=domain_home + '/security/WebLogicKey.properties',
        url=admin_server_url)

shutdown(admin_server_name, 'Server', ignoreSessions='true', force='true')

exit()
