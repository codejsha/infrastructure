#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function create_instance {
    bash ./create-instance.sh inst1 8080 8443 8005
    bash ./create-instance.sh inst2 8081 8444 8006
}

function create_instance_cluster {
    bash ./create-instance-cluster.sh inst1 8080 8443 8005 8009 8050
    bash ./create-instance-cluster.sh inst2 8081 8444 8006 8010 8051
}

function create_instance_cluster_full {
    bash ./create-instance-cluster-full.sh inst1 8080 8443 8005 8009 8050
    bash ./create-instance-cluster-full.sh inst2 8081 8444 8006 8010 8051
}

function create_instance_cluster_redis {
    bash ./create-instance-cluster-redis.sh inst1 8080 8443 8005 8009 8050
    bash ./create-instance-cluster-redis.sh inst2 8081 8444 8006 8010 8051
}

function create_script {
    # bash ./create-scripts.sh inst1 8080 8443 8005
    # bash ./create-scripts.sh inst2 8081 8444 8006
    bash ./create-scripts.sh inst1 8080 8443 8005 8009 8050
    bash ./create-scripts.sh inst2 8081 8444 8006 8010 8051
}

######################################################################

# create_instance
create_instance_cluster
# create_instance_cluster_full
# create_instance_cluster_redis

create_script
