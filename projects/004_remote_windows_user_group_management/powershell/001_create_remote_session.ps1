# ==========================================================
# Create Remote Session to Multiple Computers
# ==========================================================

# Define Computer Targets and  Credentials
$TargetsIP = Get-Content .\computers.txt
$Credential = Get-Credential

# Define a Loop to Iterate Each Computer and Display and Close Sessions
foreach ($pc in $TargetsIP){
    Write-Host "=== $pc ==="
    
    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential
    Write-Host "=== Session Established === " -ForegroundColor Cyan
    $Session
    Write-Host "===================================================" -ForegroundColor Red

}

Write-Host "========================================================" -ForegroundColor Yellow
Write-Host "=== Closing Currents Sessions ===" -ForegroundColor Cyan
Get-PSSession | Remove-PSSession
Get-PSSession
Write-Host "=== All Sessions Are Closed...! ===" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Yellow