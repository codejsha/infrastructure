######################################################################

Get-NetAdapter
Get-NetAdapter -IncludeHidden
Get-NetAdapter -Physical
Get-NetAdapter -Name "Ethernet"

######################################################################

Restart-NetAdapter -Name "Ethernet"
Enable-NetAdapter -Name "Ethernet"
Disable-NetAdapter -Name "Ethernet"
Rename-NetAdapter -Name "Ethernet" -NewName "ManagementAdapter"

######################################################################

Get-NetAdapterAdvancedProperty
Get-NetAdapterBinding
Get-NetAdapterHardwareInfo
Get-NetAdapterIPsecOffload
Get-NetAdapterLso
Get-NetAdapterPowerManagement
Get-NetAdapterRdma
Get-NetAdapterRsc
Get-NetAdapterRss
Get-NetAdapterStatistics
