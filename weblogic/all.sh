#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

bash ./print-env-base-info.sh

cd domain
bash ./all.sh
cd ..

cd nodemanager
bash ./all.sh
cd ..

cd cluster
bash ./all.sh
cd ..

cd server
bash ./all.sh
cd ..

cd datasource
bash ./all.sh
cd ..

cd security
bash ./all.sh
cd ..

cd deployment
bash ./all.sh
cd ..

# cd jms
# bash ./all.sh
# cd ..
