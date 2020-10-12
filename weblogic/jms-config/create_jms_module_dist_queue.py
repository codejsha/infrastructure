#!/usr/bin/env python

domain_name = os.environ.get('DOMAIN_NAME')
admin_server_listen_address = os.environ.get('ADMIN_SERVER_LISTEN_ADDRESS')
admin_server_listen_port = os.environ.get('ADMIN_SERVER_LISTEN_PORT')
admin_username = os.environ.get('ADMIN_USERNAME')
admin_password = os.environ.get('ADMIN_PASSWORD')

jmsmodule_name = os.environ.get('JMSMODULE_NAME')
distqueue_name = os.environ.get('DISTQUEUE_NAME')
distqueue_jndi = os.environ.get('DISTQUEUE_JNDI')
subdeploy_name = os.environ.get('SUBDEPLOY_NAME')


######################################################################


def create_jms_module_dist_queue(_jmsmodule_name, _distqueue_name):
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name)
    if _distqueue_name not in [distqueue.getName() for distqueue in cmo.getUniformDistributedQueues()]:
        cmo.createUniformDistributedQueue(_distqueue_name)


def set_jms_module_dist_queue_general_config(_jmsmodule_name, _distqueue_name, _distqueue_jndi,
                                             _subdeploy_name):
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name +
       '/UniformDistributedQueues/' + _distqueue_name)
    cmo.setJNDIName(_distqueue_jndi)
    if _subdeploy_name:
        cmo.setSubDeploymentName(_subdeploy_name)
    else:
        cmo.unSet('SubDeploymentName')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_jms_module_dist_queue(jmsmodule_name, distqueue_name)
set_jms_module_dist_queue_general_config(jmsmodule_name, distqueue_name, distqueue_jndi,
                                         subdeploy_name)

save()
activate()
exit()
