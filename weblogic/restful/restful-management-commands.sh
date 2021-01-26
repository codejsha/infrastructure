######################################################################

### 12.2.1.3 and later

### Server
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/AdminServer?links=none | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/ManagedServer1?links=none | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/ManagedServer2?links=none | jq

### Cluster
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/ManagedServer1/clusterRuntime?links=none | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/ManagedServer2/clusterRuntime?links=none | jq

### Datasource
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/ManagedServer1/JDBCServiceRuntime/JDBCDataSourceRuntimeMBeans?links=none | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    --header "Content-Type:application/json" \
    --header "X-Requested-By:MyClient" \
    http://test.example.com:7001/management/weblogic/latest/domainRuntime/serverRuntimes/ManagedServer2/JDBCServiceRuntime/JDBCDataSourceRuntimeMBeans?links=none | jq

######################################################################

### 10.3.6 ~ 12.2.1.2
### (deprecated in 12.2.1.3)

### Server
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/servers | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/servers/AdminServer | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/servers/ManagedServer1 | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/servers/ManagedServer2 | jq

### Cluster
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/clusters | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/clusters/BaseCluster1 | jq

### Datasource
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/datasources | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/datasources/BaseDataSource1 | jq

### Application
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/applications | jq
curl --user weblogic:welcome1 \
    --request GET \
    --header "Accept:application/json" \
    http://test.example.com:7001/management/tenant-monitoring/applications/failovertest | jq
