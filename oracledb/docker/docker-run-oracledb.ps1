$password = "$password"

git clone https://github.com/oracle/docker-images.git
# gh repo clone oracle/docker-images

cd docker-images/OracleDatabase/SingleInstance/dockerfiles

######################################################################

function New-DockerRunOracleDB19 {
    # /bin/cp -f /mnt/share/oracle-database/19c/LINUX.X64_193000_db_home.zip 19.3.0
    # bash ./buildDockerImage.sh -v 19.3.0 -e -i
    # rm -f 19.3.0/*.zip

    # $OracleDBVolumeDir="C:\volume\oracledb19"
    $OracleDBVolumeDir="$env:USERPROFILE\volume\oracledb19"
    New-Item -Path $OracleDBVolumeDir -ItemType Directory -Force

    docker container run `
        --detach `
        --name oracledb19 `
        --publish 1521:1521 `
        --publish 5500:5500 `
        --env ORACLE_SID="ORCLCDB" `
        --env ORACLE_PDB="ORCLPDB1" `
        --env ORACLE_PWD="$password" `
        --env ORACLE_CHARACTERSET="AL32UTF8" `
        --mount type="bind",src="$OracleDBVolumeDir",dst="/opt/oracle/oradata" `
        oracle/database:19.3.0-ee
}

function New-DockerRunOracleDB18 {
    # /bin/cp -f /mnt/share/oracle-database/18c/LINUX.X64_180000_db_home.zip 18.3.0
    # bash ./buildDockerImage.sh -v 18.3.0 -e -i
    # rm -f 18.3.0/*.zip

    # $OracleDBVolumeDir="C:\volume\oracledb18"
    $OracleDBVolumeDir="$env:USERPROFILE\volume\oracledb18"
    New-Item -Path $OracleDBVolumeDir -ItemType Directory -Force

    docker container run `
        --detach `
        --name oracledb18 `
        --publish 1521:1521 `
        --publish 5500:5500 `
        --env ORACLE_SID="ORCLCDB" `
        --env ORACLE_PDB="ORCLPDB1" `
        --env ORACLE_PWD="$password" `
        --env ORACLE_CHARACTERSET="AL32UTF8" `
        --mount type="bind",src="$OracleDBVolumeDir",dst="/opt/oracle/oradata" `
        oracle/database:18.3.0-ee
}

function New-DockerRunOracleDB12R2 {
    # /bin/cp -f /mnt/share/oracle-database/12cr2/linuxx64_12201_database.zip 12.2.0.1
    # bash ./buildDockerImage.sh -v 12.2.0.1 -e -i
    # rm -f 12.2.0.1/*.zip

    # $OracleDBVolumeDir="C:\volume\oracledb12"
    $OracleDBVolumeDir="$env:USERPROFILE\volume\oracledb12"
    New-Item -Path $OracleDBVolumeDir -ItemType Directory -Force

    docker container run `
        --detach `
        --name oracledb12 `
        --publish 1521:1521 `
        --publish 5500:5500 `
        --env ORACLE_SID="ORCLCDB" `
        --env ORACLE_PDB="ORCLPDB1" `
        --env ORACLE_PWD="$password" `
        --env ORACLE_CHARACTERSET="AL32UTF8" `
        --mount type="bind",src="$OracleDBVolumeDir",dst="/opt/oracle/oradata" `
        oracle/database:12.2.0.1-ee
}

function New-DockerRunOracleDB12R2OfficialVolume {
    docker pull store/oracle/database-enterprise:12.2.0.1

    docker volume create oracledb12vol

    docker container run `
        --detach `
        --name oracledb12 `
        --publish 1521:1521 `
        --mount type="bind",src="oracledb12vol",dst="/ORCL" `
        store/oracle/database-enterprise:12.2.0.1
}

function New-DockerRunOracleDB12R2Official {
    docker pull store/oracle/database-enterprise:12.2.0.1

    # $OracleDBVolumeDir="C:\volume\oracledb12"
    $OracleDBVolumeDir="$env:USERPROFILE\volume\oracledb12"
    New-Item -Path $OracleDBVolumeDir -ItemType Directory -Force

    docker container run `
        --detach `
        --name oracledb12 `
        --publish 1521:1521 `
        --mount type="bind",src="$OracleDBVolumeDir",dst="/ORCL" `
        store/oracle/database-enterprise:12.2.0.1
}

function New-DockerRunOracleDB12R1 {
    # /bin/cp -f /mnt/share/oracle-database/12cr1/linuxamd64_12102_database_1of2.zip 12.1.0.2
    # /bin/cp -f /mnt/share/oracle-database/12cr1/linuxamd64_12102_database_2of2.zip 12.1.0.2
    # bash ./buildDockerImage.sh -v 12.1.0.2 -e -i
    # rm -f 12.1.0.2/*.zip

    # $OracleDBVolumeDir="C:\volume\oracledb12"
    $OracleDBVolumeDir="$env:USERPROFILE\volume\oracledb12"
    New-Item -Path $OracleDBVolumeDir -ItemType Directory -Force

    docker container run `
        --detach `
        --name oracledb12 `
        --publish 1521:1521 `
        --publish 5500:5500 `
        --env ORACLE_SID="ORCLCDB" `
        --env ORACLE_PDB="ORCLPDB1" `
        --env ORACLE_PWD="$password" `
        --env ORACLE_CHARACTERSET="AL32UTF8" `
        --mount type="bind",src="$OracleDBVolumeDir",dst="/opt/oracle/oradata" `
        oracle/database:12.1.0.2-ee
}

function New-DockerRunOracleDB11 {
    # /bin/cp -f /mnt/share/oracle-database/11gr2/oracle-xe-11.2.0-1.0.x86_64.rpm.zip 11.2.0.2
    # bash ./buildDockerImage.sh -v 11.2.0.2 -x -i
    # rm -f 11.2.0.2/*.zip

    # $OracleDBVolumeDir="C:\volume\oracledb11"
    $OracleDBVolumeDir="$env:USERPROFILE\volume\oracledb11"
    New-Item -Path $OracleDBVolumeDir -ItemType Directory -Force

    docker container run `
        --detach `
        --name oracledb11 `
        --publish 1521:1521 `
        --publish 5500:8080 `
        --shm-size="1g" `
        --env ORACLE_PWD="$password" `
        --mount type="bind",src="$OracleDBVolumeDir",dst="/u01/app/oracle/oradata" `
        oracle/database:11.2.0.2-xe
}

######################################################################

New-DockerRunOracleDB19
# New-DockerRunOracleDB18
# New-DockerRunOracleDB12R2
# New-DockerRunOracleDB12R2OfficialVolume
# New-DockerRunOracleDB12R2Official
# New-DockerRunOracleDB12R1
# New-DockerRunOracleDB11
