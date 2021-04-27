# Login to Target

```bash
### login
sudo iscsiadm --mode node --targetname iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.17a3b3f1afa1 --portal 192.168.140.10 --login
sudo iscsiadm --mode node --targetname iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.1e09253b16bd --portal 192.168.140.10 --login
sudo iscsiadm --mode node --targetname iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.e0086a49388a --portal 192.168.140.10 --login

### logout
sudo iscsiadm --mode node --targetname iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.17a3b3f1afa1 --portal 192.168.140.10 --logout
sudo iscsiadm --mode node --targetname iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.1e09253b16bd --portal 192.168.140.10 --logout
sudo iscsiadm --mode node --targetname iqn.2003-01.org.linux-iscsi.kubeaccess.x8664:sn.e0086a49388a --portal 192.168.140.10 --logout
```
