#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']


######################################################################


def change_nodemgr_password(_domain_name, _admin_username, _admin_password):
    cd('/SecurityConfiguration/' + _domain_name)
    cmo.setNodeManagerUsername(_admin_username)
    cmo.setNodeManagerPassword(_admin_password)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

change_nodemgr_password(domain_name, admin_username, admin_password)

save()
activate()
exit()
