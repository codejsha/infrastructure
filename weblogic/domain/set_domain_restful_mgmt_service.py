#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']


######################################################################


def set_domain_restful_mgmt_service(_domain_name):
    cd('/RestfulManagementServices/' + _domain_name)
    cmo.setEnabled(True)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_domain_restful_mgmt_service(domain_name)

save()
activate()
exit()
