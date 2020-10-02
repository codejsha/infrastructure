### additional mount options

######################################################################

### bind

--mount type=bind,src=F:\share,dst=/mnt/share `
--mount type=bind,src=F:\storage,dst=/mnt/storage `

--mount type=bind,src=/mnt/share,dst=/mnt/share \
--mount type=bind,src=/mnt/storage,dst=/mnt/storage \
--mount type=bind,src=/mnt/volume/log,dst=/var/log \

######################################################################

### volume

docker volume create vol1
--mount type=volume,src=vol1,dst=/var/log `
--mount type=volume,src=vol1,dst=/var/log \
