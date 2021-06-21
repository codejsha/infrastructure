#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PASSWORD="${PASSWORD}"

curl -LJO https://downloads.mysql.com/docs/world.sql.gz
gzip -d world.sql.gz

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < world.sql
# mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql --recreate-schema world < world.sql
