function Convert-KubeVHD {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$SrcVMName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$SrcVMPath,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$DstVMName,
        [Parameter(Mandatory = $true, Position = 3)]
        [string]$DstVMPath
    )

    $SrcVHDPath = "$SrcVMPath\$SrcVMName\Virtual Hard Disks\$SrcVMName.vhdx"
    $DstVHDPath = "$DstVMPath\$DstVMName\Virtual Hard Disks\$DstVMName.vhdx"

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

# Convert-KubeVHD "KubeAccessMachine" "C:\hyper" "KubeControlPlaneMachine1" "C:\hyper"
# Convert-KubeVHD "KubeAccessMachine" "C:\hyper" "KubeControlPlaneMachine2" "C:\hyper"
# Convert-KubeVHD "KubeAccessMachine" "C:\hyper" "KubeControlPlaneMachine3" "C:\hyper"
# Convert-KubeVHD "KubeAccessMachine" "C:\hyper" "KubeNodeMachine1" "C:\hyper"
# Convert-KubeVHD "KubeAccessMachine" "C:\hyper" "KubeNodeMachine2" "C:\hyper"
# Convert-KubeVHD "KubeAccessMachine" "C:\hyper" "KubeNodeMachine3" "C:\hyper"

Convert-KubeVHD "KubeAccessMachine" "$env:USERPROFILE\hyper" "KubeControlPlaneMachine1" "$env:USERPROFILE\hyper"
Convert-KubeVHD "KubeAccessMachine" "$env:USERPROFILE\hyper" "KubeControlPlaneMachine2" "$env:USERPROFILE\hyper"
Convert-KubeVHD "KubeAccessMachine" "$env:USERPROFILE\hyper" "KubeControlPlaneMachine3" "$env:USERPROFILE\hyper"
Convert-KubeVHD "KubeAccessMachine" "$env:USERPROFILE\hyper" "KubeNodeMachine1" "$env:USERPROFILE\hyper"
Convert-KubeVHD "KubeAccessMachine" "$env:USERPROFILE\hyper" "KubeNodeMachine2" "$env:USERPROFILE\hyper"
Convert-KubeVHD "KubeAccessMachine" "$env:USERPROFILE\hyper" "KubeNodeMachine3" "$env:USERPROFILE\hyper"
