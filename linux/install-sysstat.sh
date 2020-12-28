#!/bin/bash

######################################################################

function install_sysstat_with_yum {
    sudo yum install -y sysstat
}

function install_sysstat_with_dnf {
    sudo dnf install -y sysstat
}

function install_sysstat_with_apt {
    sudo apt-get install -y sysstat
}

######################################################################

install_sysstat_with_yum
# install_sysstat_with_dnf
# install_sysstat_with_apt
