#!/bin/bash

kubectl apply -f https://download.elastic.co/downloads/eck/1.3.1/all-in-one.yaml
kubectl logs -f statefulset.apps/elastic-operator -n elastic-system
