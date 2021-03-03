function Copy-SSHKeyFile {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$HostName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$DstUser,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$DstPath
    )

    scp.exe $env:USERPROFILE\.ssh\id_rsa.pub ${DstUser}@${HostName}:${DstPath}
}

Copy-SSHKeyFile "testmacine" "root" "/root"
Copy-SSHKeyFile "testmacine" "prouser" "/home/prouser"

# Copy-SSHKeyFile "cpnode0" "confluent" "/usr/local/confluent"
# Copy-SSHKeyFile "cpnode1" "confluent" "/usr/local/confluent"
# Copy-SSHKeyFile "cpnode2" "confluent" "/usr/local/confluent"
# Copy-SSHKeyFile "cpnode3" "confluent" "/usr/local/confluent"
# Copy-SSHKeyFile "cpnode4" "confluent" "/usr/local/confluent"
# Copy-SSHKeyFile "cpnode5" "confluent" "/usr/local/confluent"
