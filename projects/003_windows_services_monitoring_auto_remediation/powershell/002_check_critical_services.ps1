# =================================================
# Check Critical Services in Multiples endpoints
# =================================================

# Define Targets
$TargetIP =  Get-Content .\computers.txt

# Define Credentials
$Credential = Get-Credential


foreach ($pc in $TargetIP){

    Write-Host "=== Connecting to $pc === " -ForegroundColor Cyan

    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential

    Invoke-Command `
        -Session $Session `
        -ScriptBlock {

            $CriticalServices = @(
                "WinRm",
                "Spooler",
                "W32Time",
                "EventLog"
            )
        Get-Service | Where-Object {$_.Name -in $CriticalServices} |
            Select-Object Name,Status,StartType
        }
    
    Get-PSSession | Remove-PSSession
    Write-Host "=== Session closed in $pc ===" -ForegroundColor Cyan
    Write-Host "===========================================================" -ForegroundColor Red
}

Write-Host "===========================================================" -ForegroundColor Yellow
Write-Host "=== All sessions are closed...! ===" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Yellow
Get-PSSession