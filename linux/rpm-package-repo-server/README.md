# Local RPM Package Repository Server

Requirements: yum-utils, createrepo

## Create repository

```bash
sudo mkdir -p /mnt/volume/example-repo/package
sudo createrepo /mnt/volume/example-repo
```

## Download packages

```bash
cd /mnt/volume/example-repo/package
sudo repotrack ${PACKAGE}

### with download path
# sudo repotrack --download_path=/mnt/volume/example-repo/package ${PACKAGE}
```

update:

```bash
sudo createrepo --update ${PACKAGE_REPO_VOLUME_DIR}
```

## Build image

```bash
docker image build --tag example-repo-server .
```

## Run

```bash
docker container run \
    --detach \
    --name example-repo-server \
    --publish 8888:8888 \
    --mount type=bind,src=/mnt/volume/example-repo,dst=/var/www/html/example-repo \
    example-repo-server
```

## Test

```bash
curl -i http://test.example.com:8888/example-repo/repodata/repomd.xml
```
