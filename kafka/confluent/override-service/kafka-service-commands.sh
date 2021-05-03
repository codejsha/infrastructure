######################################################################

### zookeeper
sudo systemctl start confluent-zookeeper

### kafka
sudo systemctl start confluent-server

### schema-registry
sudo systemctl start confluent-schema-registry

### kafka-connect
sudo systemctl start confluent-kafka-connect

### kafka-rest
sudo systemctl start confluent-kafka-rest

### ksqldb
sudo systemctl start confluent-ksqldb

### control center
sudo systemctl start confluent-control-center
