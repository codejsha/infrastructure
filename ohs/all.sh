#!/bin/bash

function all_11g {
    bash ./create-instance-11g.sh
    bash ./create-component-11g.sh

    bash ./create-scripts-11g.sh

    bash ./create-httpd-scripts-11g.sh
    bash ./create-links-script-11g.sh
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

function all_12cr2 {
    bash ./create-domain.sh
    bash ./create-component.sh

    bash ./create-nodemgr-scripts.sh
    bash ./create-scripts.sh

    bash ./create-httpd-scripts.sh
    bash ./create-links-script.sh
    bash ./create-metric-scripts.sh
}

######################################################################

# all_11g
# all_12cr1
all_12cr2
