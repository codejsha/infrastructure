function Convert-KubeVHD {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$VMPath,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$SrcVMName,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$DstVMName
    )
    
    $SrcVHDPath = "$VMPath\$SrcVMName\Virtual Hard Disks\$SrcVMName.vhdx"
    $DstVHDPath = "$VMPath\$DstVMName\Virtual Hard Disks\$DstVMName.vhdx"
    
    Remove-Item -Path "$DstVHDPath"
    Convert-VHD -Path "$SrcVHDPath" -DestinationPath "$DstVHDPath"
    Remove-VMHardDiskDrive -VMName "$DstVMName" `
        -ControllerType SCSI `
        -ControllerNumber 0 `
        -ControllerLocation 0
    ADD-VMHardDiskDrive -VMName "$DstVMName" `
        -ControllerType SCSI `
        -ControllerNumber 0 `
        -ControllerLocation 0 `
        -Path $DstVHDPath
    $HardDrive = Get-VMHardDiskDrive -VMName "$DstVMName" `
        -ControllerType SCSI `
        -ControllerNumber 0 `
        -ControllerLocation 0
    Set-VMFirmware -VMName "$DstVMName" `
        -FirstBootDevice $HardDrive
}

Convert-KubeVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeControlPlaneMachine1"
Convert-KubeVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeControlPlaneMachine2"
Convert-KubeVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeControlPlaneMachine3"
Convert-KubeVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeNodeMachine1"
Convert-KubeVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeNodeMachine2"
Convert-KubeVHD "$env:USERPROFILE\hyper" "KubeAccessMachine" "KubeNodeMachine3"
