#!/bin/bash

PASSWORD="${PASSWORD}"

curl -LJO https://downloads.mysql.com/docs/world.sql.gz
gzip -d world.sql.gz

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < world.sql
# mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql --recreate-schema world < world.sql
