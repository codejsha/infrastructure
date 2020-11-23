#!/bin/bash

######################################################################

function install_ntp_with_yum {
    sudo yum install -y ntp
}

function install_ntp_with_dnf {
    sudo dnf install -y ntp
}

function install_ntp_with_aptget {
    sudo apt-get install ntp
}

######################################################################

install_ntp_with_yum
# install_ntp_with_dnf
# install_ntp_with_aptget
