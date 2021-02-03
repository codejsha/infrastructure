######################################################################

### host config

MINIO_ALIAS="my-minio"
MINIO_ALIAS="minio-tenant-1"
MINIO_URL="http://minio.example.com"
MINIO_URL="https://minio-tenant-1.example.com"
AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
AWS_SECRET_KEY="${AWS_SECRET_KEY}"

mc config host add ${MINIO_ALIAS} ${MINIO_URL} ${AWS_ACCESS_KEY} ${AWS_SECRET_KEY} --api s3v4
mc config host ls

######################################################################

### make bucket

mc mb my-minio/default
mc mb my-minio/harbor-storage

mc mb --insecure minio-tenant-1/default
mc mb --insecure minio-tenant-1/harbor-storage

######################################################################
