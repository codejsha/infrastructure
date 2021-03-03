######################################################################
### apache kafka
######################################################################

### console

./kafka-console-consumer.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### from beginning
./kafka-console-consumer.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --from-beginning




######################################################################
### confluent kafka
######################################################################

### console

./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### from beginning
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --from-beginning

### print key
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --property print.key=true \
    --topic my-topic

######################################################################

### avro

### console
./kafka-avro-console-consumer \
    --bootstrap-server localhost:9092 \
    --property print.key=true \
    --key-deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --topic my-topic

### from beginning
./kafka-avro-console-consumer \
    --bootstrap-server localhost:9092 \
    --property print.key=true \
    --key-deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --topic my-topic \
    --from-beginning

### schema
/app/confluent/bin/kafka-avro-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --property print.key=true \
    --property schema.registry.url=http://schema-registry1:8081 \
    --topic my-topic

### max message
/app/confluent/bin/kafka-avro-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --property print.key=true \
    --property schema.registry.url=http://schema-registry1:8081 \
    --topic my-topic \
    --max-messages 1

### whitelist
--whitelist

######################################################################

### consumer group

### list
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --describe \
    --group my-group

### delete
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --delete \
    --group my-group
