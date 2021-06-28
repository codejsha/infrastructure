$IISVolumeDir = "$env:USERPROFILE\volume\iis"
New-Item -Path $IISVolumeDir -ItemType Directory -Force

######################################################################

function New-DockerRunIIS {
    docker container run `
    --detach `
    --name winiis `
    --publish 8080:80 `
    --mount type="bind",src="$IISVolumeDir/config",dst="/etc/gitlab" `
    --mount type="bind",src="F:\share",dst="$env:SystemDrive\share" `
    --mount type="bind",src="F:\storage",dst="$env:SystemDrive\storage" `
    mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2016
}

######################################################################

New-DockerRunIIS
