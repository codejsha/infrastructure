Import-Module IISAdministration
Import-Module WebAdministration

$SiteName = "helloworld"
$SiteHome = "$env:SystemDrive\inetpub\$SiteName"

# $PluginFileDir="$env:SystemDrive\share\oracle-http-server\ohs11.1.1.9\ofm_wlsplugins_generic_11.1.1.9.0_disk1_1of1"
$PluginFileDir = "$env:SystemDrive\share\oracle-http-server\ohs12.2.1.3\fmw_12.2.1.3.0_wlsplugins_Disk1_1of1"
# $PluginFileDir="$env:SystemDrive\share\oracle-http-server\ohs12.2.1.4\fmw_12.2.1.4.0_wlsplugins_Disk1_1of1"

# $PluginFile="WLSPlugin11g-64bit-IIS-win64-x64.zip"
$PluginFile = "WLSPlugin12.2.1.3.0-IIS-Win64-12.2.1.3.0.zip"
# $PluginFile="WLSPlugin12.2.1.4.0-IIS-Win64-12.2.1.4.0.zip"

$WebLogicPluginHome = "$SiteHome\weblogic-plugin"

$ProxyIni = @"
WebLogicCluster=test.example.com:7003,test.example.com:7004
DebugConfigInfo=ON
Debug=ALL
WLLogFile=$env:SystemDrive\inetpub\$SiteName\logs\wl-proxy.log
"@

######################################################################

function New-ShareSmbMapping {
    New-SmbMapping -LocalPath $env:SystemDrive\share -RemotePath "\\192.168.137.1\share"
}

function Copy-PluginFile {
    New-Item $WebLogicPluginHome -ItemType Directory -Force
    Expand-Archive `
        -Path $PluginFileDir\$PluginFile `
        -DestinationPath $WebLogicPluginHome
}

function New-ProxyInitialization {
    New-Item $WebLogicPluginHome\lib\iisproxy.ini -ItemType File -Force
    Add-Content $WebLogicPluginHome\lib\iisproxy.ini $ProxyIni
}

function Add-ProxyHandler {
    $ServerManager = Get-IISServerManager
    $WebConfig = $ServerManager.GetWebConfiguration("$SiteName")
    $ConfigSection = $WebConfig.GetSection("system.webServer/handlers")
    $ConfigCollection = Get-IISConfigCollection -ConfigElement $ConfigSection
    # $ConfigCollection = $WebConfig.GetSection("system.webServer/handlers") | Get-IISConfigCollection

    New-IISConfigCollectionElement `
        -AddAt 0 `
        -ConfigCollection $ConfigCollection `
        -ConfigAttribute @{ `
            Name            = "iisproxy"; `
            Path            = "/helloworld"; `
            Verb            = "*"; `
            Modules         = "IsapiModule"; `
            ScriptProcessor = "$WebLogicPluginHome\lib\iisproxy.dll" 
    }
    $ServerManager.CommitChanges()
}

function Add-JspMimeType {
    $ServerManager = Get-IISServerManager
    $WebConfig = $ServerManager.GetWebConfiguration("$SiteName")
    $ConfigSection = $WebConfig.GetSection("system.webServer/staticContent")
    $ConfigCollection = Get-IISConfigCollection -ConfigElement $ConfigSection
    # $ConfigCollection = $WebConfig.GetSection("system.webServer/staticContent") | Get-IISConfigCollection
    
    New-IISConfigCollectionElement `
        -AddAt 0 `
        -ConfigCollection $ConfigCollection `
        -ConfigAttribute @{ `
            fileExtension = ".jsp"; `
            mimeType      = "text/jsp" 
    } 
    $ServerManager.CommitChanges()
}

function Set-EnvironmentVariable {
    [System.Environment]::SetEnvironmentVariable
    (
        "Path", 
        "$Env:Path;$WebLogicPluginHome\lib", 
        [System.EnvironmentVariableTarget]::Machine
    )
}

######################################################################

Start-IISCommitDelay

New-ShareSmbMapping
Copy-PluginFile
New-ProxyInitialization
Add-ProxyHandler
Add-JspMimeType
Set-EnvironmentVariable

Stop-IISCommitDelay

Restart-Service -Name W3SVC
Stop-Website -Name $SiteName
Start-Website -Name $SiteName
