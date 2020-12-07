function New-ShareSmbMapping {
    New-SmbMapping -LocalPath $env:SystemDrive\share -RemotePath "\\192.168.137.1\share"
}

New-ShareSmbMapping
