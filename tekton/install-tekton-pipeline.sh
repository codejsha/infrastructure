#!/usr/bin/bash
# https://github.com/tektoncd/pipeline/

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
# TEKTON_PIPELINE_VERSION="0.15.2"
# kubectl apply --filename https://github.com/tektoncd/pipeline/releases/download/v${TEKTON_PIPELINE_VERSION}/release.yaml

# cat <<EOF > ./s3-bucket.yaml
# apiVersion: v1
# kind: Secret
# metadata:
#   name: tekton-storage
#   namespace: tekton-pipelines
# type: kubernetes.io/opaque
# stringData:
#   boto-config: |
#     [Credentials]
#     aws_access_key_id = "AWS_ACCESS_KEY_ID"
#     aws_secret_access_key = "AWS_SECRET_ACCESS_KEY"
#     [s3]
#     host = s3.us-east-1.amazonaws.com
#     [Boto]
#     https_validate_certificates = True
# ---
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: config-artifact-bucket
#   namespace: tekton-pipelines
# data:
#   location: s3://mybucket
#   bucket.service.account.secret.name: tekton-storage
#   bucket.service.account.secret.key: boto-config
#   bucket.service.account.field.name: BOTO_CONFIG
# EOF
#
# kubectl apply -f s3-bucket.yaml
