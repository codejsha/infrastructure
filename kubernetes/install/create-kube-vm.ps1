function New-KubeVM {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$VMName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$VMPath,
        [Parameter(Mandatory = $true, Position = 2)]
        [Int64]$VMMemory,
        [Parameter(Mandatory = $true, Position = 3)]
        [string]$Switch
    )

    # $InstallMedia = "F:\os-iso\CentOS-7-x86_64-DVD-1908.iso"

    New-VM -Name $VMName `
        -Path $VMPath `
        -Generation 2 `
        -MemoryStartupBytes $VMMemory `
        -Switch $Switch `
        -BootDevice VHD `
        -NewVHDPath "$VMPath\$VMName\Virtual Hard Disks\$VMName.vhdx" `
        -NewVHDSizeBytes 127GB
    Set-VMFirmware -VMName $VMName `
        -EnableSecureBoot Off
    Set-VMProcessor -VMName $VMName `
        -Count 2
    Set-VMMemory -VMName $VMName `
        -DynamicMemoryEnabled $False
    # Add-VMDvdDrive -VMName $VMName  `
    #     -ControllerNumber 0 `
    #     -ControllerLocation 1 `
    #     -Path $InstallMedia
    # $DVDDrive = Get-VMDvdDrive -VMName $VMName
    # Set-VMFirmware -VMName $VMName `
    #     -FirstBootDevice $DVDDrive
}

New-KubeVM -VMName "KubeAccessMachine" -VMPath "$env:USERPROFILE\hyper" -VMMemory 2GB -Switch "PlatformPrivate"
New-KubeVM -VMName "KubeControlPlaneMachine1" -VMPath "$env:USERPROFILE\hyper" -VMMemory 3GB -Switch "PlatformPrivate"
New-KubeVM -VMName "KubeControlPlaneMachine2" -VMPath "$env:USERPROFILE\hyper" -VMMemory 3GB -Switch "PlatformPrivate"
New-KubeVM -VMName "KubeControlPlaneMachine3" -VMPath "$env:USERPROFILE\hyper" -VMMemory 3GB -Switch "PlatformPrivate"
New-KubeVM -VMName "KubeNodeMachine1" -VMPath "$env:USERPROFILE\hyper" -VMMemory 16GB -Switch "PlatformPrivate"
New-KubeVM -VMName "KubeNodeMachine2" -VMPath "$env:USERPROFILE\hyper" -VMMemory 16GB -Switch "PlatformPrivate"
New-KubeVM -VMName "KubeNodeMachine3" -VMPath "$env:USERPROFILE\hyper" -VMMemory 16GB -Switch "PlatformPrivate"

Set-VMNetworkAdapter -VMName "KubeAccessMachine" -StaticMacAddress "00155D0004F0"
Set-VMNetworkAdapter -VMName "KubeControlPlaneMachine1" -StaticMacAddress "00155D0004F1"
Set-VMNetworkAdapter -VMName "KubeControlPlaneMachine2" -StaticMacAddress "00155D0004F2"
Set-VMNetworkAdapter -VMName "KubeControlPlaneMachine3" -StaticMacAddress "00155D0004F3"
Set-VMNetworkAdapter -VMName "KubeNodeMachine1" -StaticMacAddress "00155D0004F4"
Set-VMNetworkAdapter -VMName "KubeNodeMachine2" -StaticMacAddress "00155D0004F5"
Set-VMNetworkAdapter -VMName "KubeNodeMachine3" -StaticMacAddress "00155D0004F6"

Add-VMNetworkAdapter -VMName "KubeAccessMachine" -SwitchName "PlatformInternal"
Add-VMNetworkAdapter -VMName "KubeControlPlaneMachine1" -SwitchName "PlatformInternal"
Add-VMNetworkAdapter -VMName "KubeControlPlaneMachine2" -SwitchName "PlatformInternal"
Add-VMNetworkAdapter -VMName "KubeControlPlaneMachine3" -SwitchName "PlatformInternal"
Add-VMNetworkAdapter -VMName "KubeNodeMachine1" -SwitchName "PlatformInternal"
Add-VMNetworkAdapter -VMName "KubeNodeMachine2" -SwitchName "PlatformInternal"
Add-VMNetworkAdapter -VMName "KubeNodeMachine3" -SwitchName "PlatformInternal"
