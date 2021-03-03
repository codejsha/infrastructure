#!/bin/bash

PASSWORD="${PASSWORD}"

######################################################################

function docker_run_sqlserver2017 {
    docker container run \
        --detach \
        --name sqlserver2017 \
        --publish 1433:1433 \
         --env ACCEPT_EULA="Y" \
        --env MSSQL_PID="Developer" \
        --env SA_PASSWORD="${PASSWORD}" \
        --env MSSQL_AGENT_ENABLED="True" \
        mcr.microsoft.com/mssql/server:2017-latest
}

function docker_run_sqlserver2019 {
    docker container run \
        --detach \
        --name sqlserver2019 \
        --publish 1433:1433 \
        --env ACCEPT_EULA="Y" \
        --env MSSQL_PID="Developer" \
        --env SA_PASSWORD="${PASSWORD}" \
        --env MSSQL_AGENT_ENABLED="True" \
        mcr.microsoft.com/mssql/server:2019-latest
}

######################################################################

# docker_run_sqlserver2017
docker_run_sqlserver2019
