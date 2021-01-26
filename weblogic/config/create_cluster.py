#!/usr/bin/env python

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

cluster_name = os.environ['CLUSTER_NAME']


######################################################################


def create_cluster(_cluster_name):
    cd('/')
    if _cluster_name not in [cluster.getName() for cluster in cmo.getClusters()]:
        cmo.createCluster(_cluster_name)
    else:
        print('[ERROR] The cluster (' + cluster_name + ') already exists!')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_cluster(cluster_name)

save()
activate()
exit()
