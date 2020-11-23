#!/bin/bash

######################################################################

function install_openjdk_with_yum {
    sudo yum install -y java-1.8.0-openjdk-devel
    sudo yum install -y java-11-openjdk-devel
}

function install_openjdk_with_aptget {
    sudo apt-get install openjdk-8-jdk
    sudo apt-get install openjdk-11-jdk
}

######################################################################

install_openjdk_with_yum
# install_openjdk_with_aptget
