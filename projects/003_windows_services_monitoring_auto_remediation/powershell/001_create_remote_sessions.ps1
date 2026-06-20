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
    $Session    
    }
# Remove Sessions
Get-PSSession | Remove-PSSession
Write-Host "Sessions are closed...!" -ForegroundColor Cyan
Get-PSSession