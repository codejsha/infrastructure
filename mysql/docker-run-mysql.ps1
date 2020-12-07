docker run `
    --detach `
    --name mysql8 `
    --publish 3306:3306 `
    --env MYSQL_ROOT_PASSWORD="changeit" `
    --env PGDATA=/var/lib/postgresql/data/pgdata `
    --mount type=bind,src=$env:USERPROFILE\volume\mysql,dst=/var/lib/mysql `
    mysql:8.0.21

######################################################################

docker run `
    --detach `
    --name mysql5 `
    --publish 3306:3306 `
    --env MYSQL_ROOT_PASSWORD="changeit" `
    --env PGDATA=/var/lib/postgresql/data/pgdata `
    --mount type=bind,src=$env:USERPROFILE\volume\mysql,dst=/var/lib/mysql `
    mysql:5.7.31
