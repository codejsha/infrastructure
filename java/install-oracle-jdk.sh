#!/bin/bash

INSTALL_FILE_DIR="/mnt/share/oracle-jdk/7"
INSTALL_FILE_DIR="/mnt/share/oracle-jdk/8"
INSTALL_FILE_DIR="/mnt/share/oracle-jdk/11"

INSTALL_FILE="jdk-7u281-linux-x64.tar.gz"
INSTALL_FILE="jdk-8u271-linux-x64.tar.gz"
INSTALL_FILE="jdk-11.0.7_linux-x64_bin.tar.gz"

cp ${INSTALL_FILE_DIR}/${INSTALL_FILE} /usr/java
tar -C /usr/java -xzf /usr/java/${INSTALL_FILE}

ln -snf /usr/java/jdk1.7.0_281 /usr/java/java-1.7.0
ln -snf /usr/java/jdk1.8.0_271 /usr/java/java-1.8.0
ln -snf /usr/java/jdk-11.0.7 /usr/java/java-11

# ln -snf /usr/java/java-1.6.0 /usr/java/current
# ln -snf /usr/java/java-1.7.0 /usr/java/current
ln -snf /usr/java/java-1.8.0 /usr/java/current
# ln -snf /usr/java/java-11 /usr/java/current
