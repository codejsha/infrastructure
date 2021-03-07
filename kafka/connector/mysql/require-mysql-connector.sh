#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < mysql-connector-requirements.sql
