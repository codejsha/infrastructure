#!/usr/bin/bash

MINIO_ALIAS="myminio"
MINIO_URL="http://minio.example.com"
ACCESSKEY="admin"
SECRETKEY="changeit"

# mc config host add ALIAS URL ACCESSKEY SECRETKEY
mc config host add ${MINIO_ALIAS} ${MINIO_URL} ${ACCESSKEY} ${SECRETKEY}
mc config host ls
