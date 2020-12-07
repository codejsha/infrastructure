docker run `
    --detach `
    --name sqlserver2017 `
    --publish 1433:1433 `
    --env "ACCEPT_EULA=Y" `
    --env "SA_PASSWORD=changeit" `
    mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04
