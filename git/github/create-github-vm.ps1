$VMName = "GitHubServerMachine"
$VMPath = "D:\hyper"
$Switch = "HyperInternal"
$GitHubVHDName = "github-enterprise-2.21.7.vhd"
$StorageVHDName = "github-storage.vhd"

New-VM -Name $VMName `
    -Path $VMPath `
    -Generation 1 `
    -MemoryStartupBytes 16GB `
    -Switch $Switch `
    -BootDevice VHD `
    -VHDPath "$VMPath\$VMName\Virtual Hard Disks\$GitHubVHDName"
Set-VMProcessor -VMName $VMName -Count 2
Set-VMMemory $VMName -DynamicMemoryEnabled $false
Add-VMNetworkAdapter -VMName $VMName -SwitchName $Switch
New-VHD -Path "$VMPath\$VMName\Virtual Hard Disks\$StorageVHDName" -SizeBytes 64GB
ADD-VMHardDiskDrive -VMName $VMName `
    -ControllerType IDE `
    -ControllerNumber 0 `
    -ControllerLocation 1 `
    -Path "$VMPath\$VMName\Virtual Hard Disks\$StorageVHDName"
