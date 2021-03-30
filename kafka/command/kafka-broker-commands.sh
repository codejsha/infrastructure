######################################################################
### apache kafka
######################################################################

### broker version
./kafka-broker-api-versions.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version




######################################################################
### confluent platform
######################################################################

### broker version
./kafka-broker-api-versions \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version
