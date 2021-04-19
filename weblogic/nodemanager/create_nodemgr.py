#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

nodemgr_name = os.environ['NODEMGR_NAME']


######################################################################


def set_node_manager_user(_domain_name, _admin_username, _admin_password):
    cd('/SecurityConfiguration/' + _domain_name)
    cmo.setNodeManagerUsername(_admin_username)
    cmo.setNodeManagerPassword(_admin_password)


def create_node_manager(_nodemgr_name):
    cd('/')
    if _nodemgr_name not in [machine.getName() for machine in cmo.getMachines()]:
        cmo.createMachine(_nodemgr_name)
    else:
        print('[ERROR] The node manager (' + nodemgr_name + ') already exists!')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_node_manager_user(domain_name, admin_username, admin_password)
create_node_manager(nodemgr_name)

save()
activate()
exit()
