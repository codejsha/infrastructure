#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### aws
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.2.0 \
    --bucket velero-storage \
    --secret-file ~/.aws/credentials \
    --backup-location-config region=anyregion,s3ForcePathStyle=true,s3Url=http://minio.example.com \
    --snapshot-location-config region=anyregion,s3ForcePathStyle=true,s3Url=http://minio.example.com
