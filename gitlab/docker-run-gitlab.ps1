# https://hub.docker.com/r/gitlab/gitlab-ce

$GitlabHome="$env:USERPROFILE\volume\gitlab"
New-Item -Path $GitlabHome\config -ItemType Directory -Force
New-Item -Path $GitlabHome\logs -ItemType Directory -Force
New-Item -Path $GitlabHome\data -ItemType Directory -Force

docker run `
    --detach `
    --name my-gitlab `
    --restart unless-stopped `
    --hostname gitlab.example.com `
    --publish 9443:443 `
    --publish 9480:9480 `
    --publish 9422:22 `
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com:9480'; gitlab_rails['lfs_enabled'] = true; gitlab_rails['gitlab_shell_ssh_port'] = 9422;" `
    --mount type=bind,src=$GitlabHome/config,dst=/etc/gitlab `
    --mount type=bind,src=$GitlabHome/logs,dst=/var/log/gitlab `
    --mount type=bind,src=$GitlabHome/data,dst=/var/opt/gitlab `
    gitlab/gitlab-ce:latest
