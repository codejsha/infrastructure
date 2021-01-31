Get-ChildItem -Path *.yaml, *.sh |
ForEach-Object {
    (Get-Content -Path $_) -replace "192.168.140", "192.168.137" | Set-Content -Path $_
    # (Get-Content -Path $_) -replace "192.168.140", "10.10.10" | Set-Content -Path $_
}
