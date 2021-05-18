function New-Machine {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$VMName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$VMPath,
        [Parameter(Mandatory = $true, Position = 2)]
        [Int64]$VMProcessor,
        [Parameter(Mandatory = $true, Position = 3)]
        [Int64]$VMMemory,
        [Parameter(Mandatory = $true, Position = 4)]
        [string]$Switch
    )

    # $InstallMedia = "F:\os-iso\CentOS-7-x86_64-DVD-2009"
    # $InstallMedia = "F:\os-iso\CentOS-8.3.2011-x86_64-dvd1.iso"

    New-VM -Name $VMName `
        -Path $VMPath `
        -Generation 2 `
        -MemoryStartupBytes $VMMemory `
        -Switch $Switch `
        -BootDevice VHD `
        -NewVHDPath "$VMPath\$VMName\Virtual Hard Disks\$VMName.vhdx" `
        -NewVHDSizeBytes 256GB
    Set-VMFirmware -VMName $VMName `
        -EnableSecureBoot Off
    Set-VMProcessor -VMName $VMName `
        -Count $VMProcessor
    Set-VMMemory -VMName $VMName `
        -DynamicMemoryEnabled $false
    # Add-VMDvdDrive -VMName $VMName  `
    #     -ControllerNumber 0 `
    #     -ControllerLocation 1 `
    #     -Path $InstallMedia
    # $DVDDrive = Get-VMDvdDrive -VMName $VMName
    # Set-VMFirmware -VMName $VMName `
    #     -FirstBootDevice $DVDDrive
    Set-VM -Name $VMName `
        -AutomaticCheckpointsEnabled $false
}

######################################################################

### Internal

# New-Machine -VMName "MinikubeMachine" -VMPath "C:\hyper" -VMProcessor 4 -VMMemory 20GB -Switch "ServiceInternal"

New-Machine -VMName "MinikubeMachine" -VMPath "$env:USERPROFILE\hyper" -VMProcessor 4 -VMMemory 20GB -Switch "ServiceInternal"
