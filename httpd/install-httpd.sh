#!/bin/bash

function install_httpd_with_yum {
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
}

######################################################################

function install_httpd_with_dnf {
    sudo dnf install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
}

######################################################################

function install_httpd {
    HTTPD_HOME="/usr/local/httpd"
    INSTALL_FILE_DIR="/mnt/share/apache-http-server"
    # INSTALL_FILE_DIR="/svc/install"
    PARENT_BUILD_DIR="/svc/install"

    HTTPD_FILE="httpd-2.4.46.tar.gz"
    APR_FILE="apr-1.7.0.tar.gz"
    APRUTIL_FILE="apr-util-1.6.1.tar.gz"

    HTTPD_DIR_NAME="${HTTPD_FILE/\.tar\.gz/}"
    APR_DIR_NAME="${APR_FILE/\.tar\.gz/}"
    APRUTIL_DIR_NAME="${APRUTIL_FILE/\.tar\.gz/}"

    function check_httpd_home {
        if [ -d "${HTTPD_HOME}" ]; then
            echo "[ERROR] The HTTPD_HOME (${HTTPD_HOME}) already exists!"
            exit
        fi
    }

    function install_required_package {
        sudo yum install -y \
            gcc \
            pcre pcre-devel \
            expat expat-devel \
            openssl openssl-devel

        ### http2 requirements
        # sudo yum install -y nghttp2 libnghttp2 libnghttp2-devel
    }

    function download_install_file {
        if [ ! -f "${INSTALL_FILE_DIR}/${HTTPD_FILE}" ]; then
            sudo curl -o ${INSTALL_FILE_DIR}/${HTTPD_FILE} -LJO http://archive.apache.org/dist/httpd/${HTTPD_FILE}
        fi
        if [ ! -f "${INSTALL_FILE_DIR}/${APR_FILE}" ]; then
            sudo curl -o ${INSTALL_FILE_DIR}/${APR_FILE} -LJO http://archive.apache.org/dist/apr/${APR_FILE}
        fi
        if [ ! -f "${INSTALL_FILE_DIR}/${APRUTIL_FILE}" ]; then
            sudo curl -o ${INSTALL_FILE_DIR}/${APRUTIL_FILE} -LJO http://archive.apache.org/dist/apr/${APRUTIL_FILE}
        fi
    }

    function extract_install_file {
        tar -xzf ${INSTALL_FILE_DIR}/${HTTPD_FILE} -C ${PARENT_BUILD_DIR}
        tar -xzf ${INSTALL_FILE_DIR}/${APR_FILE} -C ${PARENT_BUILD_DIR}
        tar -xzf ${INSTALL_FILE_DIR}/${APRUTIL_FILE} -C ${PARENT_BUILD_DIR}
    }

    function include_apr_files {
        cd ${PARENT_BUILD_DIR}
        mv ${APR_DIR_NAME} ${HTTPD_DIR_NAME}/srclib/apr
        mv ${APRUTIL_DIR_NAME} ${HTTPD_DIR_NAME}/srclib/apr-util
    }

    function configure_and_install {
        ### configure
        cd ${PARENT_BUILD_DIR}/${HTTPD_DIR_NAME}
        ./configure --prefix=${HTTPD_HOME} \
            --with-included-apr \
            --enable-mpms-shared=all \
            --enable-modules=all
        # ./configure --prefix=${HTTPD_HOME} \
        #     --with-included-apr \
        #     --enable-mpms-shared=all \
        #     --enable-modules=most

        ### compile
        make
        ### install
        make install
    }

    check_httpd_home
    install_required_package
    download_install_file
    extract_install_file
    include_apr_files
    configure_and_install
}

######################################################################

# install_httpd_with_yum
# install_httpd_with_dnf
install_httpd
