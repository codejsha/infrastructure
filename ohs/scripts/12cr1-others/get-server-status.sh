#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

# HOSTNAME_IP_ADDRESS="192.168.137.150"
LISTEN_ADDRESS="127.0.0.1"
LISTEN_PORT="80"

links -dump http://${LISTEN_ADDRESS}:${LISTEN_PORT}/server-status
