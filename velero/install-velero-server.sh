#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### aws
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.2.0 \
    --bucket velero-storage \
    --secret-file ~/.aws/credentials \
    --backup-location-config region=anyregion,s3ForcePathStyle=true,s3Url=http://minio.example.com \
    --snapshot-location-config region=anyregion,s3ForcePathStyle=true,s3Url=http://minio.example.com
