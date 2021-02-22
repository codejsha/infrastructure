#!/bin/bash

kubectl apply -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml
# kubectl logs -f statefulset.apps/elastic-operator -n elastic-system

### delete
# kubectl delete -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml
