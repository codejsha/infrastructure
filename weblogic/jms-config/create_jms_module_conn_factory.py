#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

jmsmodule_name = os.environ['JMSMODULE_NAME']
connfactory_name = os.environ['CONNFACTORY_NAME']
connfactory_jndi = os.environ['CONNFACTORY_JNDI']
subdeploy_name = os.environ['SUBDEPLOY_NAME']


######################################################################


def create_jms_module_conn_factory(_jmsmodule_name, _connfactory_name):
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name)
    if _connfactory_name not in [connfactory.getName() for connfactory in cmo.getConnectionFactories()]:
        cmo.createConnectionFactory(_connfactory_name)


def set_jms_module_conn_factory_general_config(_jmsmodule_name, _connfactory_name, _connfactory_jndi,
                                               _subdeploy_name):
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name +
       '/ConnectionFactories/' + _connfactory_name)
    cmo.setJNDIName(_connfactory_jndi)
    if _subdeploy_name:
        cmo.setDefaultTargetingEnabled(False)
        cmo.setSubDeploymentName(_subdeploy_name)
    else:
        cmo.unSet('SubDeploymentName')
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name +
       '/ConnectionFactories/' + _connfactory_name + '/SecurityParams/' + _connfactory_name)
    cmo.setAttachJMSXUserId(False)
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name +
       '/ConnectionFactories/' + _connfactory_name + '/ClientParams/' + _connfactory_name)
    cmo.setClientIdPolicy('Restricted')
    cmo.setSubscriptionSharingPolicy('Exclusive')
    cmo.setMessagesMaximum(10)
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name +
       '/ConnectionFactories/' + _connfactory_name + '/TransactionParams/' + _connfactory_name)
    cmo.setXAConnectionFactoryEnabled(True)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_jms_module_conn_factory(jmsmodule_name, connfactory_name)
set_jms_module_conn_factory_general_config(jmsmodule_name, connfactory_name, connfactory_jndi,
                                           subdeploy_name)

save()
activate()
exit()
