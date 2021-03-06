#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

curl -LJO https://downloads.mysql.com/docs/world.sql.gz
gzip -d world.sql.gz

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < world.sql
# mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql --recreate-schema world < world.sql
