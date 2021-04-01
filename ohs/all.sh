#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function all_12cr2 {
    bash ./create-domain.sh
    bash ./delete-component.sh
    bash ./create-component.sh

    bash ./create-nodemgr-scripts.sh
    bash ./create-scripts.sh

    bash ./create-httpd-scripts.sh
    bash ./create-links-script.sh
    bash ./create-metric-scripts.sh
}

function all_12cr1 {
    bash ./create-domain.sh
    bash ./create-component.sh

    bash ./create-nodemgr-scripts.sh
    bash ./create-scripts.sh

    bash ./create-httpd-scripts-12cr1.sh
    bash ./create-links-script.sh
    bash ./create-metric-scripts.sh
}

function all_11g {
    bash ./create-instance-11g.sh
    bash ./create-component-11g.sh

    bash ./create-scripts-11g.sh

    bash ./create-httpd-scripts-11g.sh
    bash ./create-links-script-11g.sh
}

######################################################################

all_12cr2
# all_12cr1
# all_11g
