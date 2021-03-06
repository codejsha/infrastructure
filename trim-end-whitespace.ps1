Get-ChildItem -Recurse -File |
ForEach-Object {
    # Write-Host "[INFO] file path: $_"
    (Get-Content -Path $_).TrimEnd() | Set-Content -Path $_
}
