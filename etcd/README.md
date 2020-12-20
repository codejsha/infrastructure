# etcd

- https://github.com/etcd-io/etcd

## Install cli

```bash
bash ./install-etcdctl.sh
```

## Health check

```bash
bash ./health-check.sh
```

## Key

```bash
bash ./get-key.sh <KEYWORD>
bash ./delete-key.sh <KEY>
```

## Snapshot

```bash
bash ./save-snapshot.sh
bash ./get-snapshot-status.sh ${FILENAME}
bash ./restore-snapshot.sh ${FILENAME}
```
