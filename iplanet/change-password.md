# Change Password

## Run wadm command

```bash
cd ${IPLANET_HOME}/bin
./wadm reset-admin-password
```

```txt
Please enter admin-password> NEW_PASSWORD
Please enter admin-password again> NEW_PASSWORD
```

Restart:

```bash
${IPLANET_HOME}/admin-server/bin/startserv
${IPLANET_HOME}/admin-server/bin/stopserv
```
