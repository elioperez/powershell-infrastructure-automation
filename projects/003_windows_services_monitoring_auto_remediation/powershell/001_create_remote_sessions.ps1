# =====================================
# Create Remote Session to multiples Computers
# =====================================

$TargetsIP = Get-Content .\computers.txt
$Credential = Get-Credential

foreach ($pc in $TargetsIP) {
    Write-Host "============ $pc ==============="


    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential
        Write-Host "=== Conexion Established on $pc ===" -ForegroundColor Cyan
        Get-PSSession    
    }
# Remove Sessions
Get-PSSession | Remove-PSSession
Get-PSSession
Write-Host "Sessions are closed...!" -ForegroundColor Cyan