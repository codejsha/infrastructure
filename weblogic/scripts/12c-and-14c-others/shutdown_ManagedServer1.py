#!/usr/bin/env python

domain_home = os.environ['DOMAIN_HOME']
admin_server_url = os.environ['ADMIN_SERVER_URL']
managed_server_name = os.environ['MANAGED_SERVER_NAME']

######################################################################

connect(userConfigFile=domain_home + '/security/WebLogicConfig.properties',
        userKeyFile=domain_home + '/security/WebLogicKey.properties',
        url=admin_server_url)

shutdown(managed_server_name, 'Server', ignoreSessions='true', force='true')

exit()
