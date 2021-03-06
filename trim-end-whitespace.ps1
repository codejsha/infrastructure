Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notlike "*\contents\*" } |
ForEach-Object {
    # Write-Host "[INFO] file path: $_"
    (Get-Content -Path $_).TrimEnd() | Set-Content -Path $_
}
