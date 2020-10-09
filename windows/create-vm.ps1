### https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v
### https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/create-virtual-machine
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vm
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmprocessor
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmfirmware
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmmemory
### https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vhd

### Set VM Name, Switch Name, and Installation Media Path.
$VMName = "LinuxMachine"
$VMPath = "D:\hyper"
$Switch = "HyperInternal"
$InstallMedia = "E:\os-iso\CentOS-7-x86_64-DVD-1908.iso"
# $InstallMedia = "E:\os-iso\Windows_Server_2019_Datacenter_EVAL_en-us_17763_refresh.iso"
# $VHDName = ""

### Create New Virtual Machine
New-VM -Name $VMName -Path $VMPath -Generation 2 -MemoryStartupBytes 2GB -Switch $Switch -BootDevice VHD -NewVHDPath "$VMPath\$VMName\Virtual Hard Disks\$VMName.vhdx" -NewVHDSizeBytes 256GB
# New-VM -Name $VMName -Path $VMPath -Generation 2 -MemoryStartupBytes 2GB -Switch $Switch -BootDevice VHD -VHDPath "$VMPath\$VMName\Virtual Hard Disks\$VHDName"

### Disable Secure Boot Functionality on the Virtual Machine
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off

### Configures Virtual Processors of a Virtual Machine
Set-VMProcessor -VMName $VMName -Count 2

### Disable Dynamic Memory
Set-VMMemory $VMName -DynamicMemoryEnabled $True -MinimumBytes 512MB -StartupBytes 2GB -MaximumBytes 4GB

### Adds a virtual network adapter to a virtual machine.
# Add-VMNetworkAdapter -VMName $VMName -SwitchName $Switch

### Add DVD Drive to Virtual Machine
# Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -ControllerLocation 1 -Path $InstallMedia
### Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName
### Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive
