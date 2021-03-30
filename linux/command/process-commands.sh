######################################################################

### threads

sudo ps u -L -p ${PID}

### show threads, as if they were processes
# sudo ps u H -L -p ${PID}

######################################################################

### kill

sudo pkill --pidfile ${COREDNS_HOME}/coredns.pid
sudo kill -9 $(cat ${COREDNS_HOME}/coredns.pid)

sudo pkill -9 httpd
sudo pkill -9 java
