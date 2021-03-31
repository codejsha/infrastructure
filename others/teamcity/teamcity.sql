CREATE ROLE teamcity superuser;
CREATE SCHEMA IF NOT EXISTS teamcity authorization teamcity;
ALTER ROLE teamcity WITH LOGIN;
ALTER USER teamcity WITH PASSWORD 'teamcity';
CREATE DATABASE teamcitydb OWNER teamcity;
