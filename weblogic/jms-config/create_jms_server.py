#!/usr/bin/env python

domain_name = os.environ.get('DOMAIN_NAME')
admin_server_listen_address = os.environ.get('ADMIN_SERVER_LISTEN_ADDRESS')
admin_server_listen_port = os.environ.get('ADMIN_SERVER_LISTEN_PORT')
admin_username = os.environ.get('ADMIN_USERNAME')
admin_password = os.environ.get('ADMIN_PASSWORD')

jmsserver_name = os.environ.get('JMSSERVER_NAME')
jmsserver_store = os.environ.get('JMSSERVER_STORE')
jmsserver_target = os.environ.get('JMSSERVER_TARGET')


######################################################################


def create_jms_server(_jmsserver_name):
    cd('/')
    if _jmsserver_name not in [jmsserver.getName() for jmsserver in cmo.getJMSServers()]:
        cmo.createJMSServer(_jmsserver_name)


def set_jms_server_deploy_config(_jmsserver_name, _jmsserver_store, _jmsserver_target):
    cd('/Deployments/' + _jmsserver_name)
    cmo.setPersistentStore(getMBean('/FileStores/' + _jmsserver_store))
    set('Targets', jarray.array(
        [ObjectName('com.bea:Name=' + _jmsserver_target + ',Type=Server')], ObjectName))


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_jms_server(jmsserver_name)
set_jms_server_deploy_config(jmsserver_name, jmsserver_store, jmsserver_target)

save()
activate()
exit()
