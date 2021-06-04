#!/bin/bash

PASSWORD="${PASSWORD}"

mysqlsh root@test.example.com:3306 --password=${PASSWORD} --sql < mysql-source-requirements.sql
