#!/bin/bash

MINIO_ALIAS="my-minio"
MINIO_URL="http://minio.example.com"
AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
AWS_SECRET_KEY="${AWS_SECRET_KEY}"

mc config host add ${MINIO_ALIAS} ${MINIO_URL} ${AWS_ACCESS_KEY} ${AWS_SECRET_KEY}
mc config host ls
