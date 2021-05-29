######################################################################

### zookeeper
sudo systemctl start confluent-zookeeper
sudo systemctl status confluent-zookeeper
sudo systemctl stop confluent-zookeeper

### kafka
sudo systemctl start confluent-server
sudo systemctl status confluent-server
sudo systemctl stop confluent-server

### schema-registry
sudo systemctl start confluent-schema-registry
sudo systemctl status confluent-schema-registry
sudo systemctl stop confluent-schema-registry

### kafka-connect
sudo systemctl start confluent-kafka-connect
sudo systemctl status confluent-kafka-connect
sudo systemctl stop confluent-kafka-connect

### kafka-rest
sudo systemctl start confluent-kafka-rest
sudo systemctl status confluent-kafka-rest
sudo systemctl stop confluent-kafka-rest

### ksqldb
sudo systemctl start confluent-ksqldb
sudo systemctl status confluent-ksqldb
sudo systemctl stop confluent-ksqldb

### control center
sudo systemctl start confluent-control-center
sudo systemctl status confluent-control-center
sudo systemctl stop confluent-control-center
