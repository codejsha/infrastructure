#!/bin/bash

######################################################################

function install_tidy_with_yum {
    sudo yum install -y tidy
}

function install_tidy_with_dnf {
    sudo dnf install -y tidy
}

function install_tidy_with_apt {
    sudo apt-get install -y tidy
}

######################################################################

install_tidy_with_yum
# install_tidy_with_dnf
# install_tidy_with_apt
