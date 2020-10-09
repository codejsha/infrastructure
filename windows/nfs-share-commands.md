# File and Storage Services - NFS Share

- [New-NfsShare](https://docs.microsoft.com/en-us/powershell/module/nfs/new-nfsshare)
- [Get-NfsShare](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsShare)
- [Get-NfsSharePermission](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsSharePermission)
- [Get-NfsMountedClient](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsMountedClient)
- [Get-NfsSession](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsSession)
- [Get-NfsOpenFile](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsOpenFile)
- [Get-NfsClientConfiguration](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsClientConfiguration)
- [Get-NfsServerConfiguration](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsServerConfiguration)
- [Remove-NfsShare](https://docs.microsoft.com/en-us/powershell/module/nfs/Remove-NfsShare)
- [Get-NfsStatistics](https://docs.microsoft.com/en-us/powershell/module/nfs/Get-NfsStatistics)
- [Reset-NfsStatistics](https://docs.microsoft.com/en-us/powershell/module/nfs/Reset-NfsStatistics)

## Install windows features

```powershell
Install-WindowsFeature FS-NFS-Service
Install-WindowsFeature NFS-Client

Get-Module -ListAvailable | where -Property name -Match "nfs"
```

## New-NfsShare

```powershell
$collection = @("platform-postgres")

foreach ($item in $collection) {
    $ShareName = $item
    $SharePath = "C:\storage\$ShareName"
    $NetworkName = "SERVERMACHINE"
    $Authentication = "sys"
    $AnonymousUid = "1000"
    $AnonymousGid = "1000"
    $LanguageEncoding = "Ansi" # default
    $EnableAnonymousAccess = $False
    $EnableUnmappedAccess = $True
    $AllowRootAccess = $False
    $Permission = "readwrite"

    New-NfsShare `
        -Name $ShareName `
        -Path $SharePath `
        -NetworkName $NetworkName `
        -Authentication $Authentication `
        -AnonymousUid $AnonymousUid `
        -AnonymousGid $AnonymousGid `
        -LanguageEncoding $LanguageEncoding `
        -EnableAnonymousAccess $EnableAnonymousAccess `
        -EnableUnmappedAccess $EnableUnmappedAccess `
        -AllowRootAccess $AllowRootAccess `
        -Permission $Permission
}
```

## Get-NfsShare

```powershell
Get-NfsShare
```

## Get-NfsSharePermission

Gets information about permissions that an NFS server grants to exported NFS shares.

```powershell
Get-NfsSharePermission -Name "nfsshare01"
```

## Get-NfsMountedClient

Gets clients that are connected to an NFS server.

```powershell
Get-NfsMountedClient
```

## Get-NfsSession

Gets information about which client computers are currently connected to one or more shares on an NFS server.

```powershell
Get-NfsSession
```

## Get-NfsOpenFile

Gets information about files that are open on an NFS server for a client computer.

```powershell
Get-NfsOpenFile
```

## Get-NfsClientConfiguration

```powershell
Get-NfsClientConfiguration
```

## Get-NfsServerConfiguration

Gets configuration settings for an NFS server. The Get-NfsServerConfiguration cmdlet gets a configuration object for a Network File System (NFS) server. You can use the Set-NfsServerConfiguration cmdlet to change NFS server settings.

```powershell
Get-NfsServerConfiguration
```

## Remove-NfsShare

```powershell
Remove-NfsShare -Name "NFSshare01"
Remove-NfsShare -Path "C:\shares\NFSshare01"
```

## Get-NfsStatistics

Gets RPC call statistics that an NFS server maintains.

```powershell
Get-NfsStatistics
Get-NfsStatistics -Protocol "NFS"
Get-NfsStatistics -Protocol "NFS" -Version 4
```

## Reset-NfsStatistics

Resets RPC call statistics that an NFS server maintains.

```powershell
Reset-NfsStatistics
```
