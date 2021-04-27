# Discovery Target

```bash
sudo iscsiadm --mode discovery --type sendtargets --portal 192.168.140.10
```

```txt
### result:
192.168.140.10:3260,1 iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.17a3b3f1afa1
192.168.140.10:3260,1 iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.1e09253b16bd
192.168.140.10:3260,1 iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.e0086a49388a
```
