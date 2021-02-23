######################################################################

### plugin

### plugin list
curl -s -H "Accept:application/json" http://kafka-connect1:8083/connector-plugins/ | jq .[].class

######################################################################

### connector

### connector list
curl -s -H "Accept:application/json" http://kafka-connect1:8083/connectors | jq

### register
curl -s -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @oracle-connector.json http://kafka-connect1:8083/connectors | jq

### describe
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/oracle-connector | jq

### status
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/oracle-connector/status | jq

### delete
curl -s -H "Accept:application/json" -X DELETE http://kafka-connect1:8083/connectors/oracle-connector
