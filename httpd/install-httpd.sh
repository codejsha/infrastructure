#!/bin/bash
# http://httpd.apache.org/docs/current/install.html

### Installing on Fedora/CentOS/Red Hat Enterprise Linux
function install_on_centos {
    sudo yum install httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
}

######################################################################

function install_from_source {
    HTTPD_VERSION="2.4.46"
    APR_VERSION="1.7.0"
    APRUTIL_VERSION="1.6.1"
    PREFIX="/usr/local/httpd"
    INSTALL_FILE_DIR="/svc/install"

    sudo yum install -y gcc
    sudo yum install -y pcre pcre-devel
    sudo yum install -y expat expat-devel
    sudo yum install -y openssl openssl-devel

    curl -o ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}.tar.gz -LJO http://archive.apache.org/dist/httpd/httpd-${HTTPD_VERSION}.tar.gz
    curl -o ${INSTALL_FILE_DIR}/apr-${APR_VERSION}.tar.gz -LJO http://archive.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz
    curl -o ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION}.tar.gz -LJO http://archive.apache.org/dist/apr/apr-util-${APRUTIL_VERSION}.tar.gz

    tar -xzf ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}.tar.gz -C ${INSTALL_FILE_DIR}
    tar -xzf ${INSTALL_FILE_DIR}/apr-${APR_VERSION}.tar.gz -C ${INSTALL_FILE_DIR}
    tar -xzf ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION}.tar.gz -C ${INSTALL_FILE_DIR}

    mv ${INSTALL_FILE_DIR}/apr-${APR_VERSION} ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}/srclib/apr
    mv ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION} ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}/srclib/apr-util

    cd ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}
    ./configure --prefix=${PREFIX} \
        --with-included-apr \
        --enable-mpms-shared=all \
        --enable-modules=all
        # --enable-modules=most

    make
    make install
}

######################################################################

# install_on_centos
install_from_source
