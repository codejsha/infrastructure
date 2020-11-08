Import-Module IISAdministration

$SiteName = "helloworld"
$SiteHome = "$env:SystemDrive\inetpub\$SiteName"
$SiteAppPoolName = "HelloworldAppPool"
$SiteListenPort = "8080"

New-Item -Path $SiteHome -ItemType Directory -Force
New-Item -Path $SiteHome\history -ItemType Directory -Force
robocopy /mir /sec C:\inetpub\custerr $SiteHome
robocopy /mir /sec C:\inetpub\wwwroot $SiteHome

Start-IISCommitDelay

$Site = New-IISSite -Name $SiteName -PhysicalPath $SiteHome -BindingInformation "*:${SiteListenPort}:" -Protocol http -Passthru
$Site.Applications["/"].ApplicationPoolName = "$SiteAppPoolName"

Stop-IISCommitDelay
