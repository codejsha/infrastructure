-- mysql source connector requirements

-- create user
CREATE USER 'debezium'@'localhost' IDENTIFIED BY 'dbz';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'debezium';
FLUSH PRIVILEGES;


-- enable binary log
-- (mysql 8 is enabled by default)


-- gtid mode
SET @@GLOBAL.GTID_MODE = OFF_PERMISSIVE;
SET @@GLOBAL.GTID_MODE = ON_PERMISSIVE;
SET @@GLOBAL.GTID_MODE = ON;
SET @@GLOBAL.ENFORCE_GTID_CONSISTENCY = ON;
SHOW GLOBAL variables LIKE '%gtid%';
