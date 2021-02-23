######################################################################
### apache kafka
######################################################################

### broker version
./kafka-broker-api-versions.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version

### broker list
kubectl exec -it my-cluster-zookeeper-0 -- bin/zookeeper-shell.sh localhost:12181 ls /brokers/ids




######################################################################
### confluent kafka
######################################################################

### broker version
./kafka-broker-api-versions \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version
