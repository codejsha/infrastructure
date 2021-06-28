Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notmatch "\\.git\\|\\contents\\" } |
ForEach-Object {
    # Write-Host "[INFO] file path: $_"
    (Get-Content -Path $_).TrimEnd() | Set-Content -Path $_
}
