#!/bin/bash
# https://docs.minio.io/docs/aws-cli-with-minio.html
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html

# aws configure
### AWS Access Key ID [None]:
### AWS Secret Access Key [None]:
### Default region name [None]:
### Default output format [None]:

aws configure set default.s3.signature_version s3v4

MINIO_URL="http://minio.example.com"
# MINIO_URL="http://10.10.10.52:9000"

aws --endpoint-url ${MINIO_URL} s3 ls s3://mybucket
aws --endpoint-url ${MINIO_URL} s3 mb s3://mybucket
aws --endpoint-url ${MINIO_URL} s3 cp ${FILENAME} s3://mybucket
aws --endpoint-url ${MINIO_URL} s3 rm s3://mybucket/${FILENAME}
aws --endpoint-url ${MINIO_URL} s3 rb s3://mybucket
