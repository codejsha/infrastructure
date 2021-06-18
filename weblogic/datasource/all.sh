#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################
### ORACLE DATABASE
######################################################################

### CREATE DATASOURCE
### bash ./create-datasource.sh ${DS_NAME}

bash ./create-datasource.sh BaseDataSource1

######################################################################

### CONFIGURE DATASOURCE
### bash ./set-datasource-config.sh ${DS_NAME} ${DS_JNDI} \
###     ${DS_URL} \
###     ${DS_DRIVER} ${DS_USERNAME} ${DS_PASSWORD} \
###     ${DS_INIT} ${DS_MIN} ${DS_MAX} ${DS_TARGET_TYPE} ${DS_TARGET}

bash ./set-datasource-config.sh BaseDataSource1 "baseds1" \
    "jdbc:oracle:thin:@test.example.com:1521:orclcdb" \
    oracle.jdbc.OracleDriver system PASSWORD \
    30 30 30 Cluster "BaseCluster1"
# bash ./set-datasource-config.sh BaseDataSource1 "baseds1" \
#    "jdbc:oracle:thin:@test.example.com:1521:orclcdb" \
#     oracle.jdbc.OracleDriver system PASSWORD \
#     30 30 30 Cluster "BaseCluster1,BaseCluster2"
# bash ./set-datasource-config.sh BaseDataSource1 "baseds1" \
#     "jdbc:oracle:thin:@test.example.com:1521:orclcdb" \
#     oracle.jdbc.OracleDriver system PASSWORD \
#     30 30 30 Server "ManagedServer1"
# bash ./set-datasource-config.sh BaseDataSource1 "baseds11,baseds12" \
#     "jdbc:oracle:thin:@test.example.com:1521:orclcdb" \
#     oracle.jdbc.OracleDriver system PASSWORD \
#     30 30 30 Server "ManagedServer1,ManagedServer2"




######################################################################
### MYSQL
######################################################################

### CREATE DATASOURCE
### bash ./create-datasource.sh ${DS_NAME}

# bash ./create-datasource.sh BaseDataSource2

######################################################################

### CONFIGURE DATASOURCE
### bash ./set-datasource-config.sh ${DS_NAME} ${DS_JNDI} \
###     ${DS_URL} \
###     ${DS_DRIVER} ${DS_USERNAME} ${DS_PASSWORD} \
###     ${DS_INIT} ${DS_MIN} ${DS_MAX} ${DS_TARGET_TYPE} ${DS_TARGET}

# bash ./set-datasource-config.sh BaseDataSource2 "baseds2" \
#     "jdbc:mysql://test.example.com:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD \
#     30 30 30 Cluster "BaseCluster1"
# bash ./set-datasource-config.sh BaseDataSource2 "baseds2" \
#     "jdbc:mysql://test.example.com:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD \
#     30 30 30 Cluster "BaseCluster1,BaseCluster2"
# bash ./set-datasource-config.sh BaseDataSource2 "baseds2" \
#     "jdbc:mysql://test.example.com:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD \
#     30 30 30 Server "ManagedServer1"
# bash ./set-datasource-config.sh BaseDataSource2 "baseds21,baseds22" \
#     "jdbc:mysql://test.example.com:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD \
#     30 30 30 Server "ManagedServer1,ManagedServer2"




######################################################################
### SQL SERVER
######################################################################

### CREATE DATASOURCE
### bash ./create-datasource.sh ${DS_NAME}

# bash ./create-datasource.sh BaseDataSource3

######################################################################

### CONFIGURE DATASOURCE
### bash ./set-datasource-config.sh ${DS_NAME} ${DS_JNDI} \
###     ${DS_URL} \
###     ${DS_DRIVER} ${DS_USERNAME} ${DS_PASSWORD} \
###     ${DS_INIT} ${DS_MIN} ${DS_MAX} ${DS_TARGET_TYPE} ${DS_TARGET}

# bash ./set-datasource-config.sh BaseDataSource3 "baseds3" \
#     "jdbc:sqlserver://test.example.com:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD \
#     30 30 30 Cluster "BaseCluster1"
# bash ./set-datasource-config.sh BaseDataSource3 "baseds3" \
#     "jdbc:sqlserver://test.example.com:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD \
#     30 30 30 Cluster "BaseCluster1,BaseCluster2"
# bash ./set-datasource-config.sh BaseDataSource3 "baseds3" \
#     "jdbc:sqlserver://test.example.com:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD \
#     30 30 30 Server "ManagedServer1"
# bash ./set-datasource-config.sh BaseDataSource3 "baseds31,baseds32" \
#     "jdbc:sqlserver://test.example.com:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD \
#     30 30 30 Server "ManagedServer1,ManagedServer2"
