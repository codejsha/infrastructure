#!/usr/bin/bash

COREDNS_HOME="/svc/infrastructure/coredns"

function stop_coredns {
    sudo pkill -pidfile ${COREDNS_HOME}/coredns.pid
    # sudo kill -9 $(cat ${COREDNS_HOME}/coredns.pid)
}

stop_coredns
