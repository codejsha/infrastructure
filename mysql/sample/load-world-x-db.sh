#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

PASSWORD="${PASSWORD}"

curl -LJO https://downloads.mysql.com/docs/world_x-db.tar.gz
tar -xzf world_x-db.tar.gz

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < world_x-db/world_x.sql
# mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql --recreate-schema world_x < world_x-db/world_x.sql

# mysqlsh mysqlx://root@test.example.com:33060/world_x
