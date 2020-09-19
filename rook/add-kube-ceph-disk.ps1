function Add-KubeCephVHD {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$VMPath,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$VMName,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$DiskName,
        [Parameter(Mandatory = $true, Position = 3)]
        [UInt64]$Size
    )

    $CephVHDPath = "$VMPath\$VMName\Virtual Hard Disks\$DiskName.vhdx"

    if (Get-VMHardDiskDrive -VMName $VMName -ControllerType SCSI -ControllerNumber 0 -ControllerLocation 1) {
        Remove-VMHardDiskDrive -VMName $VMName -ControllerType SCSI -ControllerNumber 0 -ControllerLocation 1
    }
    if (Test-Path -Path "$CephVHDPath") {
        Remove-Item -Path "$CephVHDPath"
    }
    New-VHD -Path "$CephVHDPath"-SizeBytes $Size
    ADD-VMHardDiskDrive -VMName $VMName `
        -ControllerType SCSI `
        -ControllerNumber 0 `
        -ControllerLocation 1 `
        -Path $CephVHDPath
}

Add-KubeCephVHD "$env:USERPROFILE\hyper" "KubeNodeMachine1" "KubeNodeCephDisk1" 512GB
Add-KubeCephVHD "$env:USERPROFILE\hyper" "KubeNodeMachine2" "KubeNodeCephDisk2" 512GB
Add-KubeCephVHD "$env:USERPROFILE\hyper" "KubeNodeMachine3" "KubeNodeCephDisk3" 512GB
