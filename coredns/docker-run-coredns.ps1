# $CoreDNSVolumeDir = "C:\volume\gitlab"
$CoreDNSVolumeDir = "$env:USERPROFILE\volume\coredns"
New-Item -Path $CoreDNSVolumeDir -ItemType Directory -Force
Copy-Item -Path corefile-server.conf -Destination $CoreDNSVolumeDir\Corefile -Force

######################################################################

function New-DockerRunCoreDNS {
    docker container run `
        --detach `
        --name coredns `
        --restart unless-stopped `
        --publish 53:53/udp `
        --mount type="bind",src="$CoreDNSVolumeDir",dst="/root/coredns" `
        coredns/coredns:latest `
        -conf /root/coredns/Corefile
}

######################################################################

New-DockerRunCoreDNS
