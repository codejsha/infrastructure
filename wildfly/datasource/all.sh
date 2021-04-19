#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### JDBC MODULE
bash ./add-jdbc-module.sh
# bash ./add-jdbc-module.sh --port-offset=0
# bash ./add-jdbc-module.sh --port-offset=1

### JDBC DRIVER (AS MODULE)

# bash ./add-jdbc-driver-as-module.sh
bash ./add-jdbc-driver-as-module.sh --port-offset=0
bash ./add-jdbc-driver-as-module.sh --port-offset=1

######################################################################

### JDBC DRIVER (AS DEPLOYMENT)

# bash ./add-jdbc-driver-as-deployment.sh
# bash ./add-jdbc-driver-as-deployment.sh --port-offset=0
# bash ./add-jdbc-driver-as-deployment.sh --port-offset=1

######################################################################

# bash ./add-datasource.sh
bash ./add-datasource.sh --port-offset=0
bash ./add-datasource.sh --port-offset=1

######################################################################

# bash ./set-datasource.sh
# bash ./set-datasource.sh --port-offset=0
# bash ./set-datasource.sh --port-offset=1

######################################################################

# bash ./set-cached-connection-manager.sh
bash ./set-cached-connection-manager.sh --port-offset=0
bash ./set-cached-connection-manager.sh --port-offset=1

######################################################################

# bash ./enable-datasource-statistics.sh
# bash ./enable-datasource-statistics.sh --name=baseds1
# bash ./enable-datasource-statistics.sh --port-offset=0
# bash ./enable-datasource-statistics.sh --port-offset=1
bash ./enable-datasource-statistics.sh --port-offset=0 --name=baseds1
bash ./enable-datasource-statistics.sh --port-offset=1 --name=baseds1

######################################################################

# bash ./get-datasource-driver.sh
# bash ./get-datasource-driver.sh --driver-name=oracle
# bash ./get-datasource-driver.sh --port-offset=0
# bash ./get-datasource-driver.sh --port-offset=1
# bash ./get-datasource-driver.sh --port-offset=0 --driver-name=oracle
# bash ./get-datasource-driver.sh --port-offset=1 --driver-name=oracle

# bash ./get-datasource.sh
# bash ./get-datasource.sh --port-offset=0
# bash ./get-datasource.sh --port-offset=1

# bash ./get-datasource-statistics.sh
# bash ./get-datasource-statistics.sh --name=baseds1
# bash ./get-datasource-statistics.sh --port-offset=0
# bash ./get-datasource-statistics.sh --port-offset=1
# bash ./get-datasource-statistics.sh --port-offset=0 --name=baseds1
# bash ./get-datasource-statistics.sh --port-offset=1 --name=baseds1

######################################################################

# bash ./test-datasource-connection.sh
# bash ./test-datasource-connection.sh --name=baseds1
# bash ./test-datasource-connection.sh --port-offset=0
# bash ./test-datasource-connection.sh --port-offset=1
# bash ./test-datasource-connection.sh --port-offset=0 --name=baseds1
# bash ./test-datasource-connection.sh --port-offset=1 --name=baseds1

######################################################################

# bash ./delete-datasource.sh
# bash ./delete-datasource.sh --name=baseds1
# bash ./delete-datasource.sh --port-offset=0
# bash ./delete-datasource.sh --port-offset=1
# bash ./delete-datasource.sh --port-offset=0 --name=baseds1
# bash ./delete-datasource.sh --port-offset=1 --name=baseds1

######################################################################

### DELETE JDBC DRIVER (WITH MODULE)

# bash ./delete-jdbc-driver.sh
# bash ./delete-jdbc-driver.sh --driver-name=oracle
# bash ./delete-jdbc-driver.sh --port-offset=0
# bash ./delete-jdbc-driver.sh --port-offset=1
# bash ./delete-jdbc-driver.sh --port-offset=0 --driver-name=oracle
# bash ./delete-jdbc-driver.sh --port-offset=1 --driver-name=oracle

# bash ./delete-module.sh
# bash ./delete-module.sh --module-name=com.oracle
# bash ./delete-module.sh --port-offset=0
# bash ./delete-module.sh --port-offset=1
# bash ./delete-module.sh --port-offset=0 --module-name=com.oracle
# bash ./delete-module.sh --port-offset=1 --module-name=com.oracle

######################################################################

### DELETE JDBC DRIVER (WITH DEPLOYMENT)

# bash ./delete-jdbc-driver.sh
# bash ./delete-jdbc-driver.sh --driver-name=oracle
# bash ./delete-jdbc-driver.sh --port-offset=0
# bash ./delete-jdbc-driver.sh --port-offset=1
# bash ./delete-jdbc-driver.sh --port-offset=0 --driver-name=oracle
# bash ./delete-jdbc-driver.sh --port-offset=1 --driver-name=oracle

# bash ./undeploy-jdbc-driver.sh
# bash ./undeploy-jdbc-driver.sh --driver-name=oracle
# bash ./undeploy-jdbc-driver.sh --port-offset=0
# bash ./undeploy-jdbc-driver.sh --port-offset=1
# bash ./undeploy-jdbc-driver.sh --port-offset=0 --driver-name=oracle
# bash ./undeploy-jdbc-driver.sh --port-offset=1 --driver-name=oracle
