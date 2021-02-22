#!/bin/bash

kubectl apply -f kibana.yaml

# kubectl get secret elasticstack-es-elastic-user -o=jsonpath='{.data.elastic}' -n elastic-system | base64 --decode; echo
