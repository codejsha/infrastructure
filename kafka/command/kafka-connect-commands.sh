######################################################################

### plugin

### list
curl --include --request GET --header "Accept:application/json" http://localhost:8083/connector-plugins | jq .[].class
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connector-plugins | jq .[].class
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connector-plugins | jq .[].class

### validate connector
jq .config postgresql-source.json > postgresql-source-temp.json
curl --include --request PUT --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source-temp.json http://localhost:8083/connector-plugins/PostgresConnector/config/validate | jq
curl --include --request PUT --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source-temp.json http://kafka-connect1:8083/connector-plugins/PostgresConnector/config/validate | jq
curl --include --request PUT --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source-temp.json http://kafka-connect.example.com/connector-plugins/PostgresConnector/config/validate | jq

######################################################################

### connector

### list
curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors | jq

### register
curl --include --request POST --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source.json http://localhost:8083/connectors | jq
curl --include --request POST --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source.json http://kafka-connect1:8083/connectors | jq
curl --include --request POST --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source.json http://kafka-connect.example.com/connectors | jq

### describe
curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source | jq

### config
curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source/config | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source/config | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source/config | jq

### update
jq .config postgresql-source.json > postgresql-source-temp.json
curl --include --request PUT --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source-temp.json http://localhost:8083/connectors/postgresql-source/config | jq
curl --include --request PUT --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source-temp.json http://kafka-connect1:8083/connectors/postgresql-source/config | jq
curl --include --request PUT --header "Accept:application/json" --header "Content-Type:application/json" --data @postgresql-source-temp.json http://kafka-connect.example.com/connectors/postgresql-source/config | jq

### status
curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source/status | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source/status | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source/status | jq

### delete
curl --include --request GET --header "Accept:application/json" -X DELETE http://localhost:8083/connectors/postgresql-source
curl --include --request GET --header "Accept:application/json" -X DELETE http://kafka-connect1:8083/connectors/postgresql-source
curl --include --request GET --header "Accept:application/json" -X DELETE http://kafka-connect.example.com/connectors/postgresql-source

######################################################################

### topic

curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source/topics | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source/topics | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source/topics | jq

######################################################################

### task

curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source/tasks | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source/tasks | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source/tasks | jq

curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source/tasks/0 | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source/tasks/0 | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source/tasks/0 | jq

curl --include --request GET --header "Accept:application/json" http://localhost:8083/connectors/postgresql-source/tasks/0/status | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect1:8083/connectors/postgresql-source/tasks/0/status | jq
curl --include --request GET --header "Accept:application/json" http://kafka-connect.example.com/connectors/postgresql-source/tasks/0/status | jq
