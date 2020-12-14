#!/bin/bash

function install_centos_with_yum {
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
}

######################################################################

function install_centos_with_dnf {
    sudo dnf install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
}

######################################################################

function install_from_online_source {
    HTTPD_HOME="/usr/local/httpd"
    INSTALL_FILE_DIR="/mnt/share/apache-http-server"
    PARENT_BUILD_DIR="/svc/install"

    HTTPD_VERSION="2.4.46"
    APR_VERSION="1.7.0"
    APRUTIL_VERSION="1.6.1"

    sudo yum install -y gcc
    sudo yum install -y pcre pcre-devel
    sudo yum install -y expat expat-devel
    sudo yum install -y openssl openssl-devel

    ### http2 requirements
    # sudo yum install -y nghttp2 libnghttp2 libnghttp2-devel

    /usr/bin/cp -f ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}.tar.gz ${PARENT_BUILD_DIR}
    /usr/bin/cp -f ${INSTALL_FILE_DIR}/apr-${APR_VERSION}.tar.gz ${PARENT_BUILD_DIR}
    /usr/bin/cp -f ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION}.tar.gz ${PARENT_BUILD_DIR}

    cd ${PARENT_BUILD_DIR}
    tar -xzf httpd-${HTTPD_VERSION}.tar.gz -C ${PARENT_BUILD_DIR}
    tar -xzf apr-${APR_VERSION}.tar.gz -C ${PARENT_BUILD_DIR}
    tar -xzf apr-util-${APRUTIL_VERSION}.tar.gz -C ${PARENT_BUILD_DIR}

    cd ${PARENT_BUILD_DIR}
    mv apr-${APR_VERSION} httpd-${HTTPD_VERSION}/srclib/apr
    mv apr-util-${APRUTIL_VERSION} httpd-${HTTPD_VERSION}/srclib/apr-util

    cd ${PARENT_BUILD_DIR}/httpd-${HTTPD_VERSION}
    ./configure --prefix=${HTTPD_HOME} \
        --with-included-apr \
        --enable-mpms-shared=all \
        --enable-modules=all
        # --enable-modules=most

    make
    make install
}

######################################################################

function install_from_online_source {
    HTTPD_HOME="/usr/local/httpd"
    INSTALL_FILE_DIR="/svc/install"
    PARENT_BUILD_DIR="/svc/install"

    HTTPD_VERSION="2.4.46"
    APR_VERSION="1.7.0"
    APRUTIL_VERSION="1.6.1"

    sudo yum install -y gcc
    sudo yum install -y pcre pcre-devel
    sudo yum install -y expat expat-devel
    sudo yum install -y openssl openssl-devel

    ### http2 requirements
    # sudo yum install -y nghttp2 libnghttp2 libnghttp2-devel

    curl -o ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}.tar.gz -LJO http://archive.apache.org/dist/httpd/httpd-${HTTPD_VERSION}.tar.gz
    curl -o ${INSTALL_FILE_DIR}/apr-${APR_VERSION}.tar.gz -LJO http://archive.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz
    curl -o ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION}.tar.gz -LJO http://archive.apache.org/dist/apr/apr-util-${APRUTIL_VERSION}.tar.gz

    cd ${INSTALL_FILE_DIR}
    tar -xzf httpd-${HTTPD_VERSION}.tar.gz -C ${PARENT_BUILD_DIR}
    tar -xzf apr-${APR_VERSION}.tar.gz -C ${PARENT_BUILD_DIR}
    tar -xzf apr-util-${APRUTIL_VERSION}.tar.gz -C ${PARENT_BUILD_DIR}

    cd ${PARENT_BUILD_DIR}
    mv apr-${APR_VERSION} httpd-${HTTPD_VERSION}/srclib/apr
    mv apr-util-${APRUTIL_VERSION} httpd-${HTTPD_VERSION}/srclib/apr-util

    cd ${PARENT_BUILD_DIR}/httpd-${HTTPD_VERSION}
    ./configure --prefix=${HTTPD_HOME} \
        --with-included-apr \
        --enable-mpms-shared=all
    # ./configure --prefix=${HTTPD_HOME} \
    #     --with-included-apr \
    #     --enable-mpms-shared=all \
    #     --enable-modules=all

    make
    make install
}

######################################################################

# install_centos_with_yum
# install_centos_with_dnf
install_from_source
# install_from_online_source
