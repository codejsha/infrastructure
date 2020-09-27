### Installing on CentOS/Red Hat Enterprise Linux
sudo yum install httpd
sudo systemctl enable httpd
sudo systemctl start httpd

######################################################################

### Installing from source
HTTPD_VERSION="2.4.43"
APR_VERSION="1.7.0"
APRUTIL_VERSION="1.6.1"
PREFIX="/usr/local/httpd"
INSTALL_FILE_DIR="/svc/install"

curl -o ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}.tar.gz -LJO http://apache.tt.co.kr/httpd/httpd-${HTTPD_VERSION}.tar.gz
curl -o ${INSTALL_FILE_DIR}/apr-${APR_VERSION}.tar.gz -LJO http://apache.tt.co.kr/apr/apr-${APR_VERSION}.tar.gz
curl -o ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION}.tar.gz -LJO http://apache.tt.co.kr/apr/apr-util-${APRUTIL_VERSION}.tar.gz

tar -xvzf ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}.tar.gz -C ${INSTALL_FILE_DIR}
tar -xvzf ${INSTALL_FILE_DIR}/apr-${APR_VERSION}.tar.gz -C ${INSTALL_FILE_DIR}
tar -xvzf ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION}.tar.gz -C ${INSTALL_FILE_DIR}

mv ${INSTALL_FILE_DIR}/apr-${APR_VERSION} ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}/srclib/apr
mv ${INSTALL_FILE_DIR}/apr-util-${APRUTIL_VERSION} ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}/srclib/apr-util

cd ${INSTALL_FILE_DIR}/httpd-${HTTPD_VERSION}
./configure --prefix=${PREFIX} \
    --with-included-apr \
    --enable-modules=most
    # --enable-modules=all

make
make install
