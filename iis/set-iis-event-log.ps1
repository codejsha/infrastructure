$LogName = "Microsoft-IIS-Configuration/Operational"
$Log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
$Log.IsEnabled = $true
$Log.SaveChanges()
Get-WinEvent -Listlog "Microsoft-IIS-Configuration/Operational" | Select-Object IsEnabled
