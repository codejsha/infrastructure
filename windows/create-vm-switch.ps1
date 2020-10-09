### https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vmswitch
### https://docs.microsoft.com/en-us/powershell/module/nettcpip/new-netipaddress
### https://docs.microsoft.com/en-us/powershell/module/netnat/new-netnat
### https://wiki.archlinux.org/index.php/Hyper-V

New-VMSwitch -SwitchName "HyperInternal" -SwitchType Internal
New-NetIPAddress -InterfaceAlias "vEthernet (HyperInternal)" -IPAddress 192.168.137.1 -PrefixLength 24
New-NetNat -Name "HyperInternal NAT" -InternalIPInterfaceAddressPrefix 192.168.137.0/24

New-VMSwitch -SwitchName "ServiceInternal" -SwitchType Internal
New-NetIPAddress -InterfaceAlias "vEthernet (ServiceInternal)" -IPAddress 192.168.138.1 -PrefixLength 24
New-NetNat -Name "ServiceInternal NAT" -InternalIPInterfaceAddressPrefix 192.168.138.0/24

New-VMSwitch -SwitchName "PlatformPrivate" -SwitchType Private
New-VMSwitch -SwitchName "PlatformInternal" -SwitchType Internal
New-NetIPAddress -InterfaceAlias "vEthernet (PlatformInternal)" -IPAddress 192.168.140.1 -PrefixLength 24
New-NetNat -Name "PlatformInternal NAT" -InternalIPInterfaceAddressPrefix 192.168.140.0/24

New-VMSwitch -SwitchName "AlphaInternal" -SwitchType Internal
New-NetIPAddress -InterfaceAlias "vEthernet (AlphaInternal)" -IPAddress 192.168.200.1 -PrefixLength 24
New-NetNat -Name "AlphaInternal NAT" -InternalIPInterfaceAddressPrefix 192.168.200.0/24

Get-NetNat
