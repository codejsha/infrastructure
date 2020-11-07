#!/usr/bin/bash

INSTALL_FILE_DIR="/mnt/share/oracle-jdk/8"
INSTALL_FILE_DIR="/mnt/share/oracle-jdk/11"

INSTALL_FILE="jdk-8u251-linux-x64.tar.gz"
# INSTALL_FILE="jdk-11.0.7_linux-x64_bin.tar.gz"

cp ${INSTALL_FILE_DIR}/${INSTALL_FILE} /usr/java
tar -xzf /usr/java/${INSTALL_FILE}

ln -snf /usr/java/jdk1.8.0_251 /usr/java/java-1.8.0
# ln -snf /usr/java/jdk-11.0.7 /usr/java/java-11

# ln -snf /usr/java/java-1.6.0 /usr/java/current
# ln -snf /usr/java/java-1.7.0 /usr/java/current
ln -snf /usr/java/java-1.8.0 /usr/java/current
# ln -snf /usr/java/java-11 /usr/java/current
