### https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v
### https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/create-virtual-machine
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vm
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmprocessor
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmfirmware
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmmemory
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vhd

$VMName = "LinuxMachine"
$VMPath = "D:\hyper"
$Switch = "HyperInternal"
$InstallMedia = "F:\os-iso\CentOS-7-x86_64-DVD-2009.iso"
# $InstallMedia = "F:\os-iso\Windows_Server_2019_Datacenter_EVAL_en-us_17763_refresh.iso"
# $VHDName = ""

New-VM -Name $VMName -Path $VMPath -Generation 2 -MemoryStartupBytes 8GB -Switch $Switch -BootDevice VHD -NewVHDPath "$VMPath\$VMName\Virtual Hard Disks\$VMName.vhdx" -NewVHDSizeBytes 256GB
# New-VM -Name $VMName -Path $VMPath -Generation 2 -MemoryStartupBytes 2GB -Switch $Switch -BootDevice VHD -VHDPath "$VMPath\$VMName\Virtual Hard Disks\$VHDName"

Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Set-VMProcessor -VMName $VMName -Count 2
Set-VMMemory $VMName -DynamicMemoryEnabled $False -MinimumBytes 512MB -StartupBytes 2GB -MaximumBytes 4GB
# Set-VMMemory $VMName -DynamicMemoryEnabled $True -MinimumBytes 512MB -StartupBytes 2GB -MaximumBytes 4GB

# Add-VMNetworkAdapter -VMName $VMName -SwitchName $Switch

# Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -ControllerLocation 1 -Path $InstallMedia
$DVDDrive = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive
