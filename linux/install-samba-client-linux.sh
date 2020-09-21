#!/usr/bin/bash

sudo yum install -y \
    cifs-utils \
    samba-client

### smbclient
# smbclient -V
# smbclient //192.168.137.1/share -U shareuser

### mount
### sudo mount -t cifs -o username=${USERNAME},password=${PASSWORD} //${HOST_IP}/${SHARE_FOLDER} ${MOUNT_PATH}
# sudo mkdir /mnt/share
# sudo mount -t cifs -o user=shareuser,password=${PASSWORD} //192.168.137.1/share /mnt/share

### auto
echo "//192.168.137.1/share   /mnt/share              cifs    username=shareuser,password=${PASSWORD} 0 0" | sudo tee -a /etc/fstab
echo "//192.168.137.1/storage /mnt/storage            cifs    username=shareuser,password=${PASSWORD},uid=prouser,gid=progroup 0 0" | sudo tee -a /etc/fstab
