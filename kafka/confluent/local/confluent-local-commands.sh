######################################################################

confluent local current
confluent local version
confluent local destroy

######################################################################

confluent local services list
confluent local services start
confluent local services status
confluent local services stop
confluent local services top

######################################################################

### zookeeper

confluent local services zookeeper start
confluent local services zookeeper status
confluent local services zookeeper stop
confluent local services zookeeper top

### log
confluent local services zookeeper log
confluent local services zookeeper log -f
confluent local services zookeeper log --follow

######################################################################

### kafka

confluent local services kafka start
confluent local services kafka status
confluent local services kafka stop
confluent local services kafka top

### log
confluent local services kafka log
confluent local services kafka log -f
confluent local services kafka log --follow

### avro consumer
confluent local services kafka \
    consume ${SCHEMA_NAME} \
    --property print.key=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --value-format avro

### avro producer
confluent local services kafka \
    produce ${SCHEMA_NAME} \
    --property parse.key=true \
    --property key.separator=, \
    --property key.serializer=org.apache.kafka.common.serialization.StringSerializer \
    --value-format avro \
    --property value.schema.file=${SCHEMA_FILE}

######################################################################

### schema-registry

confluent local services schema-registry start
confluent local services schema-registry status
confluent local services schema-registry stop
confluent local services schema-registry top

### log
confluent local services schema-registry log
confluent local services schema-registry log -f
confluent local services schema-registry log --follow

### acl
confluent local services schema-registry acl --list

######################################################################

### kafka-connect

confluent local services connect start
confluent local services connect status
confluent local services connect stop
confluent local services connect top

### log
confluent local services connect log
confluent local services connect log -f
confluent local services connect log --follow

### connector
confluent local services connect connector status
confluent local services connect connector list
confluent local services connect connector config
confluent local services connect connector load
confluent local services connect connector unload

### plugin
confluent local services connect plugin list

######################################################################

### kafka-rest

confluent local services kafka-rest start
confluent local services kafka-rest status
confluent local services kafka-rest stop
confluent local services kafka-rest top

### log
confluent local services kafka-rest log
confluent local services kafka-rest log -f
confluent local services kafka-rest log --follow

######################################################################

### ksqldb

confluent local services ksql-server start
confluent local services ksql-server status
confluent local services ksql-server stop
confluent local services ksql-server top

### log
confluent local services ksql-server log
confluent local services ksql-server log -f
confluent local services ksql-server log --follow

######################################################################

### control-center

confluent local services control-center start
confluent local services control-center status
confluent local services control-center stop
confluent local services control-center top

### log
confluent local services control-center log
confluent local services control-center log -f
confluent local services control-center log --follow
