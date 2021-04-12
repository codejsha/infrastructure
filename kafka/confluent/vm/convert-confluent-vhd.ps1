function Convert-ConfluentVHD {
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

# Convert-ConfluentVHD "ConfluentNodeMachine0" "C:\hyper" "ConfluentNodeMachine1" "C:\hyper"
# Convert-ConfluentVHD "ConfluentNodeMachine0" "C:\hyper" "ConfluentNodeMachine2" "C:\hyper"
# Convert-ConfluentVHD "ConfluentNodeMachine0" "C:\hyper" "ConfluentNodeMachine3" "C:\hyper"
# Convert-ConfluentVHD "ConfluentNodeMachine0" "C:\hyper" "ConfluentNodeMachine4" "C:\hyper"
# Convert-ConfluentVHD "ConfluentNodeMachine0" "C:\hyper" "ConfluentNodeMachine5" "C:\hyper"

Convert-ConfluentVHD "ConfluentNodeMachine0" "$env:USERPROFILE\hyper" "ConfluentNodeMachine1" "$env:USERPROFILE\hyper"
Convert-ConfluentVHD "ConfluentNodeMachine0" "$env:USERPROFILE\hyper" "ConfluentNodeMachine2" "$env:USERPROFILE\hyper"
Convert-ConfluentVHD "ConfluentNodeMachine0" "$env:USERPROFILE\hyper" "ConfluentNodeMachine3" "$env:USERPROFILE\hyper"
Convert-ConfluentVHD "ConfluentNodeMachine0" "$env:USERPROFILE\hyper" "ConfluentNodeMachine4" "$env:USERPROFILE\hyper"
Convert-ConfluentVHD "ConfluentNodeMachine0" "$env:USERPROFILE\hyper" "ConfluentNodeMachine5" "$env:USERPROFILE\hyper"
