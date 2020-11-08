Import-Module IISAdministration

$SiteAppPoolName = "HelloworldAppPool"

######################################################################

function New-IISAppPoolByCCE {
    ## New-IISConfigCollectionElement (IISAdministration)

    $ConfigSection = Get-IISConfigSection -SectionPath "system.applicationHost/applicationPools"
    $ConfigCollection = Get-IISConfigCollection -ConfigElement $ConfigSection

    New-IISConfigCollectionElement `
        -ConfigCollection $ConfigCollection `
        -ConfigAttribute @{ `
            "name" = "$SiteAppPoolName"; `
            "autoStart" = $true; `
            "managedPipelineMode" = "Integrated" }
}

function New-IISAppPoolBySM {
    ### Get-IISServerManager (IISAdministration)

    $ServerManager = Get-IISServerManager
    $ServerManager.ApplicationPools.Add($SiteAppPoolName)
    $ServerManager.CommitChanges()
}

######################################################################

Start-IISCommitDelay

# New-IISAppPoolByCCE
New-IISAppPoolBySM

Stop-IISCommitDelay

Get-IISAppPool -Name $SiteAppPoolName
