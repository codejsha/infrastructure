# Create Backstore

## Format disk

```bash
sudo fdisk /dev/sdb
```

```txt
Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x48fa4989.

Command (m for help): n
```

```txt
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p):  // ENTER

Using default response p.
```

```txt
Partition number (1-4, default 1):  // ENTER
First sector (2048-2147483647, default 2048):  // ENTER 
Last sector, +sectors or +size{K,M,G,T,P} (2048-2147483647, default 2147483647):  // ENTER

Created a new partition 1 of type 'Linux' and of size 1024 GiB.
```

```txt
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

list block devices (`lsblk`):

```txt
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0   256G  0 disk 
├─sda1        8:1    0   200M  0 part /boot/efi
├─sda2        8:2    0     1G  0 part /boot
└─sda3        8:3    0 254.8G  0 part 
  └─cl-root 253:0    0 254.8G  0 lvm  /
sdb           8:16   0     1T  0 disk 
└─sdb1        8:17   0  1024G  0 part 
```

## Create target backstore

```bash
sudo targetcli
```

```txt
/> /backstores/block 
/> create name=block_backend dev=/dev/sdb
Created block storage object block_backend using /dev/sdb.
```

```txt
/> ls
o- / ......................................................................................................................... [...]
  o- backstores .............................................................................................................. [...]
  | o- block .................................................................................................. [Storage Objects: 1]
  | | o- block_backend .................................................................. [/dev/sdb (1.0TiB) write-thru deactivated]
  | |   o- alua ................................................................................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ....................................................................... [ALUA state: Active/optimized]
  | o- fileio ................................................................................................. [Storage Objects: 0]
  | o- pscsi .................................................................................................. [Storage Objects: 0]
  | o- ramdisk ................................................................................................ [Storage Objects: 0]
  o- iscsi ............................................................................................................ [Targets: 0]
  o- loopback ......................................................................................................... [Targets: 0]
```
