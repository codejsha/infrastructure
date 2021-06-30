######################################################################

### threads

sudo ps u -L -p ${PID}

### show threads, as if they were processes
# sudo ps u H -L -p ${PID}

######################################################################

### kill

sudo pkill -9 httpd
sudo pkill -9 java

sudo pkill --pidfile ${COREDNS_HOME}/coredns.pid
sudo kill -9 $(cat ${COREDNS_HOME}/coredns.pid)

sudo pkill -9 --echo --count --exact httpd
sudo pkill -9 --echo --count --exact java

sudo pkill -9 --echo --count --full "org.apache.zookeeper.server.quorum.QuorumPeerMain"
sudo pkill -9 --echo --count --full "kafka.Kafka"
sudo pkill -9 --echo --count --full "io.confluent.kafka.schemaregistry.rest.SchemaRegistryMain"
sudo pkill -9 --echo --count --full "org.apache.kafka.connect.cli.ConnectDistributed"
sudo pkill -9 --echo --count --full "io.confluent.kafkarest.KafkaRestMain"
sudo pkill -9 --echo --count --full "io.confluent.ksql.rest.server.KsqlServerMain"
sudo pkill -9 --echo --count --full "io.confluent.controlcenter.ControlCenter"
