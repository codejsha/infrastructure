#!/usr/bin/bash

MINIO_ALIAS="myminio"
MINIO_URL="http://minio.example.com"
ACCESS_KEY="admin"
SECRET_KEY="SECRET_KEY"

# mc config host add ALIAS URL ACCESS_KEY SECRET_KEY
mc config host add ${MINIO_ALIAS} ${MINIO_URL} ${ACCESS_KEY} ${SECRET_KEY}
mc config host ls
