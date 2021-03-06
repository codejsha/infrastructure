#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_confluent_kafka_with_download {
    local CONFLUENT_HOME="/usr/local/confluent"
    local INSTALL_FILE_DIR="/mnt/share/confluent-platform"
    local INSTALL_FILE="confluent-6.2.0.tar.gz"

    local CONFLUENT_MAJOR_VERSION="$(echo ${CONFLUENT_VERSION} | grep -o -E "^[0-9]{1,3}")"
    local PARENT_CONFLUENT_HOME="$(readlink --canonicalize-missing ${CONFLUENT_HOME}/../)"
    local CONFLUENT_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "([^confluent-].*[^\.tar\.gz])")"

    function check_install_home {
        if [ -d "${CONFLUENT_HOME}" ]; then
            echo "[ERROR] The CONFLUENT_HOME (${CONFLUENT_HOME}) already exists!"
            exit
        fi
    }

    function download_install_file {
        if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
            sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
                -LJO http://packages.confluent.io/archive/${CONFLUENT_MAJOR_VERSION}/${INSTALL_FILE}
        fi
    }

    function check_install_file {
        if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
            echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
            exit
        fi
    }

    function install_confluent {
        sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_CONFLUENT_HOME}
        sudo mv ${PARENT_CONFLUENT_HOME}/confluent-${CONFLUENT_VERSION} ${CONFLUENT_HOME}
        sudo chown -R $(id -un):$(id -gn) ${CONFLUENT_HOME}
    }

    function install_bash_completion {
        sudo yum install -y bash-completion
        sudo /usr/local/confluent/bin/confluent completion bash | sudo tee /etc/bash_completion.d/confluent
    }

    check_install_home
    download_install_file
    check_install_file
    install_confluent
    install_bash_completion

    ### add path
    # CONFLUENT_HOME="/usr/local/confluent"
    # PATH="${PATH}:${CONFLUENT_HOME}/bin"
    # export PATH
}

function install_confluent_kafka_with_yum {
cat <<EOF | sudo tee /etc/yum.repos.d/confluent.repo
[Confluent.dist]
name=Confluent repository (dist)
baseurl=https://packages.confluent.io/rpm/6.2/\$releasever
gpgcheck=1
gpgkey=https://packages.confluent.io/rpm/6.2/archive.key
enabled=1

[Confluent]
name=Confluent repository
baseurl=https://packages.confluent.io/rpm/6.2
gpgcheck=1
gpgkey=https://packages.confluent.io/rpm/6.2/archive.key
enabled=1
EOF

    sudo yum install -y curl which
    sudo yum install -y confluent-platform
    sudo yum install -y confluent-security
}

######################################################################

install_confluent_kafka_with_download
# install_confluent_kafka_with_yum
