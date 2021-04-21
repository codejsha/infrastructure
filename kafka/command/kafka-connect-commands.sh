######################################################################

### plugin

### list
curl -s -H "Accept:application/json" http://kafka-connect1:8083/connector-plugins | jq .[].class

######################################################################

### connector

### list
curl -s -H "Accept:application/json" http://kafka-connect1:8083/connectors | jq

### register
curl -s -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @postgresql-connector.json http://kafka-connect1:8083/connectors | jq

### describe
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector | jq

### config
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector/config | jq

### status
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector/status | jq

### validate
# jq .config postgresql-connector.json > postgresql-connector-temp.json
curl -s -X PUT -H "Accept:application/json" -H "Content-Type:application/json" -d @postgresql-connector-temp.json http://kafka-connect1:8083/connector-plugins/PostgresConnector/config/validate | jq

### delete
curl -s -H "Accept:application/json" -X DELETE http://kafka-connect1:8083/connectors/postgresql-connector

######################################################################

### topic

curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector/topics | jq

######################################################################

### task

curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector/tasks | jq
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector/tasks/0 | jq
curl -s -H "Accept:application/json" -X GET http://kafka-connect1:8083/connectors/postgresql-connector/tasks/0/status | jq
