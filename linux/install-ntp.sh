#!/bin/bash

######################################################################

function install_ntp_with_yum {
    sudo yum install -y ntp
    sudo systemctl enable ntpd
    sudo systemctl start ntpd
}

function install_ntp_with_dnf {
    sudo dnf install -y ntp
    sudo systemctl enable ntpd
    sudo systemctl start ntpd
}

function install_ntp_with_apt {
    sudo apt-get install ntp
}

######################################################################

install_ntp_with_yum
# install_ntp_with_dnf
# install_ntp_with_apt
