######################################################################

### broker

### broker list
./zookeeper-shell zookeeper1:2181,zookeeper2:2181,zookeeper3:2181 ls /brokers/ids

### broker list (testcluster znode)
./zookeeper-shell zookeeper1:2181,zookeeper2:2181,zookeeper3:2181 ls /testcluster/brokers/ids

### broker list (kafka-confluent-operator znode)
kubectl exec zookeeper-0 -c zookeeper -- zookeeper-shell localhost:2181 ls /kafka-confluent-operator/brokers/ids
