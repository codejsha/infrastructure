######################################################################

### delete centos-home

cd /
tar -czf home.tar.gz /home
umount /home
lvremove /dev/mapper/centos-home
lvextend -r -l +100%FREE /dev/mapper/centos-root
tar -xzf home.tar.gz
### comment centos-home in fstab
sed -i "s/^\/dev\/mapper\/centos-home/#\/dev\/mapper\/centos-home" /etc/fstab
