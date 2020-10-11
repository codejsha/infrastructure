# https://github.com/oracle/docker-images

git clone https://github.com/oracle/docker-images.git
cd docker-images/OracleDatabase/SingleInstance/dockerfiles

######################################################################

# bash ./buildDockerImage.sh -v 11.2.0.2 -x -i
docker run `
    --detach `
    --name oracledb11 `
    --shm-size=1g `
    --publish 1521:1521 `
    --publish 5500:8080 `
    --env ORACLE_PWD="changeit" `
    --mount type=bind,src=$env:USERPROFILE\volume\oracledb11,dst=/u01/app/oracle/oradata `
    oracle/database:11.2.0.2-xe

######################################################################

# bash ./buildDockerImage.sh -v 12.1.0.2 -e -i
docker run `
    --detach `
    --name oracledb12 `
    --publish 1521:1521 `
    --publish 5500:5500 `
    --env ORACLE_SID=ORCLCDB `
    --env ORACLE_PDB=ORCLPDB1 `
    --env ORACLE_PWD="changeit" `
    --env ORACLE_CHARACTERSET=AL32UTF8 `
    --mount type=bind,src=$env:USERPROFILE\volume\oracledb12,dst=/opt/oracle/oradata `
    oracle/database:12.1.0.2-ee

######################################################################

# bash ./buildDockerImage.sh -v 12.2.0.1 -e -i
docker run `
    --detach `
    --name oracledb12 `
    --publish 1521:1521 `
    --publish 5500:5500 `
    --env ORACLE_SID=ORCLCDB `
    --env ORACLE_PDB=ORCLPDB1 `
    --env ORACLE_PWD="changeit" `
    --env ORACLE_CHARACTERSET=AL32UTF8 `
    --mount type=bind,src=$env:USERPROFILE\volume\oracledb12,dst=/opt/oracle/oradata `
    oracle/database:12.1.0.2-ee

docker pull store/oracle/database-enterprise:12.2.0.1
docker volume create oracledb12vol
docker run `
    --detach `
    --name oracledb12 `
    --publish 1521:1521 `
    --mount type=bind,src=oracledb12vol,dst=/ORCL `
    store/oracle/database-enterprise:12.2.0.1
docker run `
    --detach `
    --name oracledb12 `
    --publish 1521:1521 `
    --mount type=bind,src=$env:USERPROFILE\volume\oracledb12,dst=/ORCL `
    store/oracle/database-enterprise:12.2.0.1

######################################################################

# bash ./buildDockerImage.sh -v 18.3.0 -e -i
docker run `
    --detach `
    --name oracledb18 `
    --publish 1521:1521 `
    --publish 5500:5500 `
    --env ORACLE_SID=ORCLCDB `
    --env ORACLE_PDB=ORCLPDB1 `
    --env ORACLE_PWD="changeit" `
    --env ORACLE_CHARACTERSET=AL32UTF8 `
    --mount type=bind,src=$env:USERPROFILE\volume\oracledb18,dst=/opt/oracle/oradata `
    oracle/database:18.3.0-ee

######################################################################

# bash ./buildDockerImage.sh -v 19.3.0 -e -i
docker run `
    --detach `
    --name oracledb19 `
    --publish 1521:1521 `
    --publish 5500:5500 `
    --env ORACLE_SID=ORCLCDB `
    --env ORACLE_PDB=ORCLPDB1 `
    --env ORACLE_PWD="changeit" `
    --env ORACLE_CHARACTERSET=AL32UTF8 `
    --mount type=bind,src=$env:USERPROFILE\volume\oracledb19,dst=/opt/oracle/oradata `
    oracle/database:19.3.0-ee
