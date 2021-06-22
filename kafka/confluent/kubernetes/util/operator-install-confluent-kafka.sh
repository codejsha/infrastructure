#!/bin/bash

kubectl create namespace confluent-operator

curl -LJO https://platform-ops-bin.s3-us-west-1.amazonaws.com/operator/confluent-operator-1.7.0.tar.gz
mkdir confluent-operator
tar -xzf confluent-operator-1.7.0.tar.gz -C confluent-operator

cd confluent-operator/scripts

### install
./operator-util.sh --release-prefix confluent --namespace confluent-operator --helm-file ../../../values.yaml

### upgrade
# ./operator-util.sh --upgrade --release-prefix confluent --namespace confluent-operator --helm-file ../../../values.yaml

### delete
# ./operator-util.sh --delete --release-prefix confluent --namespace confluent-operator --helm-file ../../../values.yaml
