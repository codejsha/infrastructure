#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

PGPASSWORD="${PASSWORD}" psql --host=test.example.com --port=5432 --username=postgres --file=postgresql-connector-requirements.sql
