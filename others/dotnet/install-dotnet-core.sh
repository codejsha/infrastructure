#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### CentOS 8

### sdk
sudo dnf install -y dotnet-sdk-3.1

### runtime
# sudo dnf install -y dotnet-runtime-3.1
# sudo dnf install -y aspnetcore-runtime-3.1

######################################################################

### CentOS 7

# sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm

### sdk
# sudo yum install -y dotnet-sdk-3.1

### runtime
# sudo yum install -y dotnet-runtime-3.1
# sudo yum install -y aspnetcore-runtime-3.1
