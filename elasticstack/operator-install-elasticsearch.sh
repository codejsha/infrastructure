#!/bin/bash

kubectl apply -f elasticsearch.yaml

# kubectl get secret elasticstack-es-elastic-user -o=jsonpath='{.data.elastic}' -n elastic-system | base64 --decode; echo
