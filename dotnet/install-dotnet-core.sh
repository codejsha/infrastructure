#!/usr/bin/bash

######################################################################

### CentOS 7

sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
### sdk
sudo yum install dotnet-sdk-3.1
### runtime
# sudo yum install aspnetcore-runtime-3.1
# sudo yum install dotnet-runtime-3.1

######################################################################

### CentOS 8

### sdk
# sudo dnf install dotnet-sdk-3.1
### runtime
# sudo dnf install aspnetcore-runtime-3.1
# sudo dnf install dotnet-runtime-3.1

######################################################################
