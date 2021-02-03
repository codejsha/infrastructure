#!/bin/bash

NAMESPACE="minio-operator"

kubectl minio init --namespace ${NAMESPACE}
# kubectl minio delete --namespace ${NAMESPACE}
