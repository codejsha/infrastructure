# Get-WinEvent "Microsoft-IIS-Configuration/Operational"
# Get-WinEvent "Microsoft-IIS-Configuration/Operational" | Format-List -Property TimeCreated, Message
Get-WinEvent "Microsoft-IIS-Configuration/Operational" | Select-Object -Property TimeCreated, Message | Select-Object -First 10
# Get-WinEvent "Microsoft-IIS-Configuration/Operational" | Format-List -Property TimeCreated, Message | Select-Object -First 10
