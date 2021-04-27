## Configure ACLs

## Find initiator's unique name

in `/etc/iscsi/initiatorname.iscsi` file on client nodes:

```txt
### access
InitiatorName=iqn.1994-05.com.redhat:a84cc5752c60

### controlplane1
InitiatorName=iqn.1994-05.com.redhat:45fb50e1124
### controlplane2
InitiatorName=iqn.1994-05.com.redhat:7ccd6a52f29
### controlplane3
InitiatorName=iqn.1994-05.com.redhat:6940d2bde0e2

### node1
InitiatorName=iqn.1994-05.com.redhat:92b84d137023
### node2
InitiatorName=iqn.1994-05.com.redhat:7610b4221259
### node3
InitiatorName=iqn.1994-05.com.redhat:86ef5276a8fb
```

## Create ACLs

```bash
sudo targetcli
```

```txt
/> /iscsi/iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.17a3b3f1afa1/tpg1
/> /iscsi/iqn.20...b3f1afa1/tpg1> acls/ create iqn.1994-05.com.redhat:a84cc5752c60
Created Node ACL for iqn.1994-05.com.redhat:a84cc5752c60
Created mapped LUN 0.

/> /iscsi/iqn.20...b3f1afa1/tpg1> acls/ create iqn.1994-05.com.redhat:92b84d137023
/> /iscsi/iqn.20...b3f1afa1/tpg1> acls/ create iqn.1994-05.com.redhat:7610b4221259
/> /iscsi/iqn.20...b3f1afa1/tpg1> acls/ create iqn.1994-05.com.redhat:86ef5276a8fb
```

```txt
/iscsi/iqn.20...b3f1afa1/tpg1> ls
o- tpg1 ..................................................................................................... [no-gen-acls, no-auth]
  o- acls ................................................................................................................ [ACLs: 4]
  | o- iqn.1994-05.com.redhat:86ef5276a8fb ........................................................................ [Mapped LUNs: 1]
  | | o- mapped_lun0 ............................................................................... [lun0 block/block_backend (rw)]
  | o- iqn.1994-05.com.redhat:7610b4221259 ........................................................................ [Mapped LUNs: 1]
  | | o- mapped_lun0 ............................................................................... [lun0 block/block_backend (rw)]
  | o- iqn.1994-05.com.redhat:92b84d137023 ........................................................................ [Mapped LUNs: 1]
  | | o- mapped_lun0 ............................................................................... [lun0 block/block_backend (rw)]
  | o- iqn.1994-05.com.redhat:a84cc5752c60 ........................................................................ [Mapped LUNs: 1]
  |   o- mapped_lun0 ............................................................................... [lun0 block/block_backend (rw)]
  o- luns ................................................................................................................ [LUNs: 1]
  | o- lun0 .................................................................... [block/block_backend (/dev/sdb) (default_tg_pt_gp)]
  o- portals .......................................................................................................... [Portals: 1]
    o- 0.0.0.0:3260 ........................................................................................................... [OK]
```
