#!/bin/bash

oc create -n confluent-operator -f confluent-operator/scripts/openshift/customUID/scc.yaml
