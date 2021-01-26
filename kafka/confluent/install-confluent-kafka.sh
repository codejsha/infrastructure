#!/bin/bash

CONFLUENT_MAJOR_VERSION="6.0"
CONFLUENT_VERSION="6.0.1"

curl -LJO http://packages.confluent.io/archive/${CONFLUENT_MAJOR_VERSION}/confluent-${CONFLUENT_VERSION}.tar.gz
tar -xzf confluent-${CONFLUENT_VERSION}.tar.gz
sudo mv confluent-${CONFLUENT_VERSION} /usr/local/confluent

### add to .bashrc
# PATH="${PATH}:/usr/local/confluent/bin"
# source /etc/bash_completion.d/confluent
