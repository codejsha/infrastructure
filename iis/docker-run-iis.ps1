# https://hub.docker.com/_/microsoft-windows-servercore-iis

$MountSrc = "F:\share"
$MountDst = "$env:SystemDrive\mnt\share"
$IISPublishPort = "8080"
$SiteListenPort = "80"

### run iis container
docker run `
    --detach `
    --name winiis `
    --publish $IISPublishPort\:$SiteListenPort `
    --mount type=bind,src=$MountSrc,dst=$MountDst `
    mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2016

docker exec -it winiis powershell
