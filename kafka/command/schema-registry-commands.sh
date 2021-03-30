######################################################################

### schema

curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/schemas/types | jq
### [
###   "JSON",
###   "PROTOBUF",
###   "AVRO"
### ]

######################################################################

### subject

curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/subjects | jq

### version
curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/subjects/sakila-value/versions | jq
curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/subjects/sakila-value/versions/1 | jq
curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/subjects/sakila-value/versions/1/schema | jq

######################################################################

### compatibility

curl -s -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @schema.json http://schema-registry1:8081/compatibility/subjects/test/versions/latest

######################################################################

### mode

curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/mode | jq

######################################################################

### config

curl -s -H "Accept:application/json" -X GET http://schema-registry1:8081/config | jq
