$SiteAppPoolName = "HelloworldAppPool"

Start-IISCommitDelay

$ConfigSection = Get-IISConfigSection -SectionPath "system.applicationHost/applicationPools"
$ConfigCollection = Get-IISConfigCollection -ConfigElement $ConfigSection

New-IISConfigCollectionElement `
    -ConfigCollection $ConfigCollection `
    -ConfigAttribute @{ `
        "name" = "$SiteAppPoolName"; `
        "autoStart" = $true; `
        "managedPipelineMode" = "Integrated" }

Stop-IISCommitDelay

Get-IISAppPool -Name $SiteAppPoolName
