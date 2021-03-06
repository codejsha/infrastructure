-- ######################################################################

-- version
select version();

-- ######################################################################

-- create user
CREATE USER debezium WITH ENCRYPTED PASSWORD 'dbz';
ALTER ROLE debezium WITH REPLICATION LOGIN;

-- ######################################################################

-- grant table permission
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO debezium;

-- ######################################################################

-- check connection

SHOW max_connections;
SELECT COUNT(*) FROM pg_stat_activity;
SELECT pid, query, state FROM pg_stat_activity;
SELECT pid, query, state FROM pg_stat_activity WHERE state LIKE 'idle';
