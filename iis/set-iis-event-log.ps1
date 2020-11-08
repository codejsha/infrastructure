$LogName = "Microsoft-IIS-Configuration/Operational"
$Operational = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
$Operational.IsEnabled = $true
$Operational.SaveChanges()
Get-WinEvent -Listlog "Microsoft-IIS-Configuration/Operational" | Select-Object IsEnabled
