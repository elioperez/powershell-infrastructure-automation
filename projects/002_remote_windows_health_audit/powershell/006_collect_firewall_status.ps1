# ==============================
# Collect Firewall Status in Multiple Computers
# ==============================

$Targets = $computers
$Credential = Get-Credential


foreach ($pc in $Targets){
    
    Write-Host " ================ Checking $pc ===============" -ForegroundColor Cyan

    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential

    Invoke-Command `
        -Session $Session `
        -ScriptBlock {
            Get-NetFirewallProfile |
                Select-Object Name,Enabled

    Get-PSSession | Remove-PSSession
    Get-PSSession
    Write-Host ""
    Write-Host " ======= Session is Closed...! ============" -ForegroundColor Cyan
    Write-Host ""    }

}