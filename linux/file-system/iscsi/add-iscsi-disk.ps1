function Add-KubeIscsiVHD {
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

    $IscsiVHDPath = "$VMPath\$VMName\Virtual Hard Disks\$DiskName.vhdx"

    $ControllerLocation = 0
    while ($True) {
        $ControllerLocation += 1
        $AlreadyExist = (Get-VMHardDiskDrive -VMName $VMName -ControllerType SCSI -ControllerNumber 0 -ControllerLocation $ControllerLocation)
        Write-Output $AlreadyExist
        if (! $AlreadyExist) {
            break
        }
    }

    if (Test-Path -Path "$IscsiVHDPath") {
        Remove-Item -Path "$IscsiVHDPath"
    }
    New-VHD -Path "$IscsiVHDPath"-SizeBytes $Size
    ADD-VMHardDiskDrive -VMName $VMName `
        -ControllerType SCSI `
        -ControllerNumber 0 `
        -ControllerLocation $ControllerLocation `
        -Path $IscsiVHDPath
}

# Add-KubeIscsiVHD "C:\hyper" "KubeAccessMachine" "KubeIscsiDisk1" 1024GB
# Add-KubeIscsiVHD "C:\hyper" "KubeAccessMachine" "KubeIscsiDisk2" 1024GB
# Add-KubeIscsiVHD "C:\hyper" "KubeAccessMachine" "KubeIscsiDisk3" 1024GB

Add-KubeIscsiVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeIscsiDisk1" 1024GB
Add-KubeIscsiVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeIscsiDisk2" 1024GB
Add-KubeIscsiVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeIscsiDisk3" 1024GB

# Add-KubeIscsiVHD "$env:USERPROFILE\hyper" "KubeNodeMachine1" "KubeIscsiDisk1" 1024GB
# Add-KubeIscsiVHD "$env:USERPROFILE\hyper" "KubeNodeMachine2" "KubeIscsiDisk2" 1024GB
# Add-KubeIscsiVHD "$env:USERPROFILE\hyper" "KubeNodeMachine3" "KubeIscsiDisk3" 1024GB
