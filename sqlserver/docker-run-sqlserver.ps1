$password = "$password"

######################################################################

function New-DockerRunSQLServer2019 {
    docker container run `
        --detach `
        --name sqlserver2019 `
        --publish 1433:1433 `
        --env ACCEPT_EULA="Y" `
        --env MSSQL_PID="Developer" `
        --env SA_PASSWORD="${PASSWORD}" `
        --env MSSQL_AGENT_ENABLED="True" `
        mcr.microsoft.com/mssql/server:2019-latest
}

function New-DockerRunSQLServer2017 {
    docker container run `
        --detach `
        --name sqlserver2017 `
        --publish 1433:1433 `
        --env ACCEPT_EULA="Y" `
        --env MSSQL_PID="Developer" `
        --env SA_PASSWORD="${PASSWORD}" `
        --env MSSQL_AGENT_ENABLED="True" `
        mcr.microsoft.com/mssql/server:2017-latest
}

######################################################################

New-DockerRunSQLServer2019
# New-DockerRunSQLServer2017
