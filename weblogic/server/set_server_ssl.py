#!/usr/bin/env python

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']


######################################################################


def set_server_ssl_config(_server_name):
    cd('/Servers/' + _server_name + '/SSL/' + _server_name)
    cmo.setEnabled(False)
    # cmo.setLoginTimeoutMillis(25000)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_server_ssl_config(managed_server_name)

save()
activate()
exit()
