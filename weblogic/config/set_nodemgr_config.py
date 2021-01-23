#!/usr/bin/env python

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

nodemgr_name = os.environ['NODEMGR_NAME']
nodemgr_listen_address = os.environ['NODEMGR_LISTEN_ADDRESS']
nodemgr_listen_port = os.environ['NODEMGR_LISTEN_PORT']


######################################################################


def set_node_manager_config(_nodemgr_name, _nodemgr_listen_address, _nodemgr_listen_port):
    cd('/Machines/' + _nodemgr_name + '/NodeManager/' + _nodemgr_name)
    cmo.setNMType('Plain')
    cmo.setListenAddress(_nodemgr_listen_address)
    cmo.setListenPort(int(_nodemgr_listen_port))
    cmo.setDebugEnabled(False)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_node_manager_config(nodemgr_name, nodemgr_listen_address, nodemgr_listen_port)

save()
activate()
exit()
