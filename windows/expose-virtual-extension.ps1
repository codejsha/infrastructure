Get-VMProcessor -VMName "AzureStackMachine" | fl
Set-VMProcessor -VMName "AzureStackMachine" -ExposeVirtualizationExtensions $True
