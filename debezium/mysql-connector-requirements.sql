-- create user
CREATE USER 'debezium'@'localhost' IDENTIFIED BY 'dbz';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'debezium' IDENTIFIED BY 'dbz';
FLUSH PRIVILEGES;


-- enable binary log (mysql 8 is enabled by default)
--
-- SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
-- FROM information_schema.global_variables WHERE variable_name='log_bin';


-- gtid mode
-- 
-- SHOW GLOBAL variables LIKE '%GTID%';
SET @@GLOBAL.GTID_MODE = OFF_PERMISSIVE;
SET @@GLOBAL.GTID_MODE = ON_PERMISSIVE;
SET @@GLOBAL.GTID_MODE = ON;
SET @@GLOBAL.ENFORCE_GTID_CONSISTENCY = ON;
