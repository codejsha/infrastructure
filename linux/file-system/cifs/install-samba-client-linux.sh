#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

sudo yum install -y \
    cifs-utils \
    samba-client

### smbclient
# smbclient -V
# smbclient //192.168.137.1/share -U shareuser

### mount
### sudo mount -t cifs -o username=${USERNAME},password=${PASSWORD} //${HOST_IP}/${SHARE_FOLDER} ${MOUNT_PATH}
# sudo mkdir /mnt/share
# sudo mkdir /mnt/storage
# sudo mount -t cifs -o user=shareuser,password=${PASSWORD} //192.168.137.1/share /mnt/share
# sudo mount -t cifs -o user=shareuser,password=${PASSWORD} //192.168.137.1/storage /mnt/storage
# sudo mount -t cifs -o user=shareuser,password=${PASSWORD} //192.168.140.1/share /mnt/share
# sudo mount -t cifs -o user=shareuser,password=${PASSWORD} //192.168.140.1/storage /mnt/storage

### auto
echo "//192.168.137.1/share   /mnt/share              cifs    username=shareuser,password=${PASSWORD},file_mode=0755,dir_mode=0755 0 0" | sudo tee -a /etc/fstab
echo "//192.168.137.1/storage /mnt/storage            cifs    username=shareuser,password=${PASSWORD},uid=prouser,gid=progroup 0 0" | sudo tee -a /etc/fstab
# echo "//192.168.140.1/share   /mnt/share              cifs    username=shareuser,password=${PASSWORD},file_mode=0755,dir_mode=0755 0 0" | sudo tee -a /etc/fstab
# echo "//192.168.140.1/storage /mnt/storage            cifs    username=shareuser,password=${PASSWORD},uid=prouser,gid=progroup 0 0" | sudo tee -a /etc/fstab

### umount
# sudo umount /mnt/share
# sudo umount /mnt/storage
