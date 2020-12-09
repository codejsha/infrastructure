# Red Hat CodeReady Containers

- https://code-ready.github.io/crc/

## Requirements

Hyper-V:

```powershell
Set-VMProcessor -VMName "LinuxServerMachine" -ExposeVirtualizationExtensions $true
Get-VMProcessor -VMName "LinuxServerMachine" | Format-List -Property ExposeVirtualizationExtensions
```

## Install

```bash
bash ./pre-install-crc.sh
bash ./install-crc.sh
bash ./remote-access-crc.sh
```
