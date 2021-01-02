# Security

## Disable directory index

- `disable-directory-index.sh`

## Password encryption

### Credential Store

```bash
bash ./create-credential-store.sh
bash ./add-credential.sh ${PASSWORD}
```

use credential:

```txt
--credential-reference={store=${CREDENTIAL_STORE_NAME}, alias=${CREDENTIAL_ALIAS}}
```

- https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/how_to_configure_server_security/index#credential_store

### Password Valut

```bash
bash ./encrypt-password-with-password-vault.sh ${PASSWORD}

### Result format
### ${VAULT::VAULT_BLOCK::ATTRIBUTE_NAME::MASKED_STRING}

### Run vault configuration commands in CLI (jboss-cli)
### For standalone mode: // ...
### For domain mode: // ...
```

- https://access.redhat.com/solutions/2790371
- https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/how_to_configure_server_security/index#password_vault

### PicketBox

```bash
bash ./encrypt-password-with-picketbox.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/184963