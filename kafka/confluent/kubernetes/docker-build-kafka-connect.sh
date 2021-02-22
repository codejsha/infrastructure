#!/bin/bash

### build, tag 6.1.0.0
docker image build --file Dockerfile.kafka-connect --tag core.harbor.example.com/library/cp-custom-kafka-connect-operator:6.1.0.0 .
docker image push core.harbor.example.com/library/cp-custom-kafka-connect-operator:6.1.0.0

### build, tag latest
# docker image build --file Dockerfile.kafka-connect --tag core.harbor.example.com/library/cp-custom-kafka-connect-operator:latest .
# docker image push core.harbor.example.com/library/cp-custom-kafka-connect-operator:latest
