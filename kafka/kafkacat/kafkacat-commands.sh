######################################################################

alias kafkacat="docker container run -it --network host edenhill/kafkacat:1.6.0"
alias kafkacat="docker container run -it --stream-network host edenhill/kafkacat:1.6.0"

### version
docker container run -it --network host edenhill/kafkacat:1.6.0 -V

######################################################################

### topic

kafkacat -b localhost:9092 -t pageviews -L
kafkacat -b kafka1:9092,kafka2:9092,kafka3:9092 -t pageviews -L

######################################################################

### producer

######################################################################

### consumer

### avro consumer

kafkacat -b localhost:9092 -t pageviews -s avro -r http://localhost:8081
kafkacat -b localhost:9092 -t pageviews -s avro -r http://localhost:8081 -c10
kafkacat -b kafka1:9092,kafka2:9092,kafka3:9092 -t pageviews -s avro -r http://schema-registry1:8081
kafkacat -b kafka1:9092,kafka2:9092,kafka3:9092 -t pageviews -s avro -r http://schema-registry1:8081 -c10

kafkacat -b localhost:9092 -s avro -r http://localhost:8081 -G mygroup pageviews users
kafkacat -b localhost:9092 -s avro -r http://localhost:8081 -c10 -G mygroup pageviews users
