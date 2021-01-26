#!/usr/bin/env python

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']


######################################################################


def create_server(_server_name):
    cd('/')
    if _server_name not in [server.getName() for server in cmo.getServers()]:
        cmo.createServer(_server_name)
    else:
        print('[ERROR] The managed server (' + managed_server_name + ') already exists!')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

create_server(managed_server_name)

save()
activate()
exit()
