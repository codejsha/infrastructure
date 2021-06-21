#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PASSWORD="${PASSWORD}"

curl -LJO http://downloads.mysql.com/docs/sakila-db.tar.gz
tar -xzf sakila-db.tar.gz

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < sakila-db/sakila-schema.sql
mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < sakila-db/sakila-data.sql
# mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql --recreate-schema sakila < sakila-db/sakila-schema.sql
# mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql --recreate-schema sakila < sakila-db/sakila-data.sql
