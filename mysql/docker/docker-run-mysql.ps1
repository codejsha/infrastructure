$password = "$password"

# $MySQLVolumeDir = "C:\volume\mysql"
$MySQLVolumeDir = "$env:USERPROFILE\volume\mysql"
New-Item -Path $MySQLVolumeDir\data -ItemType Directory -Force

######################################################################

function New-DockerRunMySQL8 {
    docker container run `
        --detach `
        --name mysql8 `
        --publish 3306:3306 `
        --publish 33060:33060 `
        --env MYSQL_ROOT_PASSWORD="$password" `
        --mount type="bind",src="$MySQLVolumeDir\data",dst="/var/lib/mysql" `
        mysql:8.0.23

        # --mount type="bind",src="$MySQLVolumeDir\config-file.cnf",dst="/etc/mysql/conf.d/config-file.cnf" `
    }

function New-DockerRunMySQL5 {
        docker container run `
        --detach `
        --name mysql5 `
        --publish 3306:3306 `
        --publish 33060:33060 `
        --env MYSQL_ROOT_PASSWORD="$password" `
        --mount type="bind",src="$MySQLVolumeDir\data",dst="/var/lib/mysql" `
        mysql:5.7.33

        # --mount type="bind",src="$MySQLVolumeDir\config-file.cnf",dst="/etc/mysql/conf.d/config-file.cnf" `
}

######################################################################

New-DockerRunMySQL8
# New-DockerRunMySQL5
