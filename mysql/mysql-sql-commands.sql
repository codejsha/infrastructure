-- ######################################################################

-- database

-- create
CREATE DATABASE database_name;
CREATE DATABASE database_name DEFAULT CHARACTER SET utf8;

-- set active schema
USE mysql;

-- ######################################################################

-- status
\status
\s

-- ######################################################################

-- show query
SHOW DATABASES;
SHOW TABLES;
\show query show databases;
\show query show tables;

-- ######################################################################

-- user

SELECT user, host FROM user;
-- +------------------+-----------+
-- | user             | host      |
-- +------------------+-----------+
-- | root             | %         |
-- | mysql.infoschema | localhost |
-- | mysql.session    | localhost |
-- | mysql.sys        | localhost |
-- | root             | localhost |
-- +------------------+-----------+

-- local access
CREATE USER 'prouser'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'debezium'@'localhost' IDENTIFIED BY 'dbz';

-- remote access
CREATE USER 'prouser'@'%' IDENTIFIED BY 'password';
CREATE USER 'debezium'@'%' IDENTIFIED BY 'dbz';

-- ######################################################################

-- privilege

GRANT ALL PRIVILEGES ON *.* TO 'prouser'@'%';
GRANT ALL PRIVILEGES ON db_name.* TO 'prouser'@'%';
GRANT ALL PRIVILEGES ON sakila.* TO 'debezium'@'%';

FLUSH PRIVILEGES;

-- ######################################################################

-- password

ALTER USER 'debezium'@'%' IDENTIFIED WITH mysql_native_password BY 'dbz';

UPDATE user SET password=password('new_password') WHERE user='root';

-- ######################################################################

-- execute file
SOURCE sakila-db/sakila-schema.sql
SOURCE sakila-db/sakila-data.sql
