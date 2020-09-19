#!/usr/bin/bash

MAVEN_VERSION="3.6.3"

# http://mirror.apache-kr.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip
curl -JLO http://mirror.apache-kr.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

sudo tar -xf apache-maven-${MAVEN_VERSION}-bin.tar.gz
sudo mv apache-maven-${MAVEN_VERSION} maven
sudo mv maven /usr/local

### add path
# PATH="${PATH}:/usr/local/maven/bin"
# export PATH
