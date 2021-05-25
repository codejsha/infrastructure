######################################################################
### apache kafka
######################################################################

### broker version

./kafka-broker-api-versions.sh --version

./kafka-broker-api-versions.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version




######################################################################
### confluent kafka
######################################################################

### broker version

./kafka-broker-api-versions --version

./kafka-broker-api-versions \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version
