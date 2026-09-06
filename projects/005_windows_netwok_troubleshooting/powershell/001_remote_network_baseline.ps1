# remote_network_baselineremote

# Define the remote Windows target
$TargetIP = @(
    "192.168.56.125"
    "192.168.56.127"
)

# Request credentials securely
$Credential = Get-Credential



# Collect the basic network baseline remotely
foreach ($pc in $TargetIP){
    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential

    Write-Host "============== $pc =================" -ForegroundColor Cyan `

    Invoke-Command `
        -Session $Session `
        -ScriptBlock {
                $Adapters = Get-NetAdapter 
    $Configuration = Get-NetIPConfiguration

    [PSCustomObject]@{
        ComputerName = $env:COMPUTERNAME
        AdapterCount = $Adapters.count
        ActiveAdapters = ($Adapters | Where-Object {$_.Status -eq "UP"}).count
        IPv4Addresses = $Configuration.IPv4Address.IPAddress
        DefaultGateways = $Configuration.IPv4DefaultGateway.NextHop
    }
        }
        
}
Get-PSSession | Remove-PSSession -Verbose