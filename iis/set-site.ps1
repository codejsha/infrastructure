Import-Module IISAdministration

$SiteName = "helloworld"
$SiteHome = "$env:SystemDrive\inetpub\$SiteName"
$SiteAppPoolName = "HelloworldAppPool"
$SiteListenPort = "8080"

Start-IISCommitDelay

$Site = Get-IISSite -Name $SiteName

$Site.Applications["/"].ApplicationPoolName = "$SiteAppPoolName"

# New-IISSiteBinding -Name "$SiteName" -BindingInformation "*:8080:" -Protocol http

# $Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "limits"
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "maxBandwidth" -AttributeValue 4294967295
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "maxConnections" -AttributeValue 4294967295
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "connectionTimeout" -AttributeValue "00:02:00"
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "MaxUrlSegments" -AttributeValue 32

$Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "logFile"
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "logExtFileFlags" -AttributeValue 2478031
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "customLogPluginClsid" -AttributeValue ""
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "logFormat" -AttributeValue W3C
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "logTargetW3C" -AttributeValue File
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "directory" -AttributeValue "$SiteHome\logs\LogFiles"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "period" -AttributeValue Daily
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "truncateSize" -AttributeValue 20971520
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "localTimeRollover" -AttributeValue $false
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "enabled" -AttributeValue $true
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "logSiteId" -AttributeValue $true
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "flushByEntryCountW3CLog" -AttributeValue 0
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "maxLogLineLength" -AttributeValue 65536

$Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "traceFailedRequestsLogging"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "enabled" -AttributeValue $true
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "directory" -AttributeValue "$SiteHome\logs\FailedReqLogFiles"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "maxLogFiles" -AttributeValue 50
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "maxLogFileSizeKB" -AttributeValue 1024
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "customActionsEnabled" -AttributeValue $false

$Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "hsts"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "enabled" -AttributeValue $true
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "max-age" -AttributeValue 0
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "includeSubDomains" -AttributeValue $true
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "preload" -AttributeValue $true
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "redirectHttpToHttps" -AttributeValue $false

$Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "applicationDefaults"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "applicationPool" -AttributeValue "$SiteAppPoolName"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "enabledProtocols" -AttributeValue "http"
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "serviceAutoStartEnabled" -AttributeValue $false
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "serviceAutoStartProvider" -AttributeValue ""
Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "preloadEnabled" -AttributeValue $false

# $Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "virtualDirectoryDefaults"
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "path" -AttributeValue ""
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "physicalPath" -AttributeValue ""
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "userName" -AttributeValue ""
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "password" -AttributeValue ""
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "logonMethod" -AttributeValue 3
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "allowSubDirConfig" -AttributeValue $true

# $Element = Get-IISConfigElement -ConfigElement $Site -ChildElementName "ftpServer"
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "state" -AttributeValue "4"
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "lastStartupStatus" -AttributeValue 0
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "allowUTF8" -AttributeValue $true
# Set-IISConfigAttributeValue -ConfigElement $Element -AttributeName "serverAutoStart" -AttributeValue $true

Stop-IISCommitDelay
