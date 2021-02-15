#!/bin/bash

function install_confluent_kafka_with_download {
    CONFLUENT_MAJOR_VERSION="6.0"
    CONFLUENT_VERSION="6.0.1"

    curl -LJO http://packages.confluent.io/archive/${CONFLUENT_MAJOR_VERSION}/confluent-${CONFLUENT_VERSION}.tar.gz
    tar -xzf confluent-${CONFLUENT_VERSION}.tar.gz

    sudo mv confluent-${CONFLUENT_VERSION} /usr/local/confluent
    sudo /usr/local/confluent/confluent completion bash > /etc/bash_completion.d/confluent
    source /etc/bash_completion.d/confluent

    ### add to .bashrc
    # CONFLUENT_HOME="/usr/local/confluent"
    # PATH="${PATH}:${CONFLUENT_HOME}/bin"
}

function install_confluent_kafka_with_yum {
cat <<EOF | sudo tee /etc/yum.repos.d/confluent.repo
[Confluent.dist]
name=Confluent repository (dist)
baseurl=https://packages.confluent.io/rpm/6.1/7
gpgcheck=1
gpgkey=https://packages.confluent.io/rpm/6.1/archive.key
enabled=1

[Confluent]
name=Confluent repository
baseurl=https://packages.confluent.io/rpm/6.1
gpgcheck=1
gpgkey=https://packages.confluent.io/rpm/6.1/archive.key
enabled=1
EOF

    yum install -y curl which
    yum install -y confluent-platform
    yum install -y confluent-security
}

######################################################################

install_confluent_kafka_with_download
# install_confluent_kafka_with_yum
