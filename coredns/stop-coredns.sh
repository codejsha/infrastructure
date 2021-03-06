#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

COREDNS_HOME="/svc/infrastructure/coredns"

######################################################################

function stop_coredns {
    sudo pkill --pidfile ${COREDNS_HOME}/coredns.pid
    # sudo kill -9 $(cat ${COREDNS_HOME}/coredns.pid)
}

######################################################################

stop_coredns
