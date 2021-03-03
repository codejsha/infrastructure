######################################################################

### broker list

./zookeeper-shell zookeeper1:2181,zookeeper2:2181,zookeeper3:2181 ls /brokers/ids

### testcluster znode
./zookeeper-shell zookeeper1:2181,zookeeper2:2181,zookeeper3:2181 ls /testcluster/brokers/ids

### kafka-confluent-operator znode
kubectl exec zookeeper-0 -c zookeeper -- zookeeper-shell localhost:2181 ls /kafka-confluent-operator/brokers/ids

### kubernetes
kubectl exec -it my-cluster-zookeeper-0 -- bin/zookeeper-shell.sh localhost:2181 ls /brokers/ids
