#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

cluster_name = os.environ['CLUSTER_NAME']
transmission = os.environ['TRANSMISSION']
multicast_listen_address = os.environ['MULTICAST_LISTEN_ADDRESS']
multicast_listen_port = os.environ['MULTICAST_LISTEN_PORT']


######################################################################


def create_cluster(_cluster_name):
    cd('/')
    if _cluster_name not in [cluster.getName() for cluster in cmo.getClusters()]:
        cmo.createCluster(_cluster_name)


def set_cluster_config(_cluster_name, _transmission, _multicast_listen_address, _multicast_listen_port):
    cd('/Clusters/' + _cluster_name)
    if _transmission == 'unicast':
        cmo.setClusterMessagingMode('unicast')
    elif _transmission == 'multicast':
        cmo.setClusterMessagingMode('multicast')
        cmo.setMulticastAddress(_multicast_listen_address)
        cmo.setMulticastPort(int(_multicast_listen_port))
    else:
        pass
    # cmo.setMemberWarmupTimeoutSeconds(30)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_cluster(cluster_name)
set_cluster_config(cluster_name, transmission, multicast_listen_address, multicast_listen_port)

save()
activate()
exit()
