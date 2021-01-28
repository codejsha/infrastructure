#!/usr/bin/env python

domain_home = os.environ['DOMAIN_HOME']
admin_server_url = os.environ['ADMIN_SERVER_URL']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

######################################################################

connect(admin_username, admin_password, admin_server_url)

storeUserConfig(domain_home + '/security/WebLogicConfig.properties',
                domain_home + '/security/WebLogicKey.properties')

exit()
