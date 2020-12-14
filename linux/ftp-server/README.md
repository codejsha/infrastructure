# FTP Server

## Build image

```bash
docker build -t ftp-server .
```

## Run

```bash
docker run \
    --detach \
    --name ftp-server \
    --publish 21:21 \
    --publish 10400-10410:10400-10410 \
    --mount type=bind,src=/mnt/share,dst=/var/ftp/pub
    ftp-server /bin/bash -c '/usr/sbin/vsftpd && tail -f /dev/null'
```

## Test

```bash
curl ftp://localhost/pub
```