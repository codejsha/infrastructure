######################################################################

### pv

pvcreate /dev/vda2

### resize
pvresize /dev/vda2

######################################################################

### vg

vgcreate myvg

### extend
sudo vgchange -a y centos
sudo vgextend centos /dev/vda2

######################################################################

### lv

lvcreate -L 100G -n myvg /dev/vda2

### extend
lvextend -r -L 100G /dev/mapper/centos-root
lvextend -r -L +100G /dev/mapper/centos-root
lvextend -r -l +100%FREE /dev/mapper/centos-root
# resize2fs /dev/vda2
# xfs_growfs /dev/centos/root
