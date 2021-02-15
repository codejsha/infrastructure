#!/bin/bash

curl -LJO https://platform-ops-bin.s3-us-west-1.amazonaws.com/operator/confluent-operator-1.7.0.tar.gz
mkdir confluent-operator
tar -xzf confluent-operator-1.7.0.tar.gz -C confluent-operator
cd confluent-operator

kubectl create namespace confluent-operator

cd scripts

### install
# ./operator-util.sh --release-prefix confluent --namespace confluent-operator --helm-file ./helm-chart-values.yaml
./operator-util.sh --release-prefix co1 --namespace confluent-operator --helm-file ./helm-chart-values.yaml

### upgrade
# ./operator-util.sh --upgrade --release-prefix confluent --namespace confluent-operator --helm-file ./helm-chart-values.yaml
# ./operator-util.sh --upgrade --release-prefix co1 --namespace confluent-operator --helm-file ./helm-chart-values.yaml

### delete
# ./operator-util.sh --delete --release-prefix co1 --namespace confluent-operator --helm-file ./helm-chart-values.yaml
