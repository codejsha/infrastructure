$GitLabVolumeDir="$env:USERPROFILE\volume\gitlab"
New-Item -Path $GitLabVolumeDir\config -ItemType Directory -Force
New-Item -Path $GitLabVolumeDir\logs -ItemType Directory -Force
New-Item -Path $GitLabVolumeDir\data -ItemType Directory -Force

docker container run `
    --detach `
    --name my-gitlab `
    --restart unless-stopped `
    --hostname gitlab `
    --publish 9443:443 `
    --publish 9480:9480 `
    --publish 9422:22 `
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com:9480'; gitlab_rails['lfs_enabled'] = true; gitlab_rails['gitlab_shell_ssh_port'] = 9422;" `
    --mount type=bind,src=$GitLabVolumeDir/config,dst=/etc/gitlab `
    --mount type=bind,src=$GitLabVolumeDir/logs,dst=/var/log/gitlab `
    --mount type=bind,src=$GitLabVolumeDir/data,dst=/var/opt/gitlab `
    gitlab/gitlab-ce:latest
