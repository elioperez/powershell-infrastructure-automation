$TargetIP = Get-Content .\computers.txt
$Credential = Get-Credential


foreach ($pc in $TargetIP){
    Write-Host "=== Connecting to $pc ===" -ForegroundColor Cyan

    $Session = New-PSSession -ComputerName $pc -Credential $Credential

    Invoke-Command -Session $Session -ScriptBlock {

        $CriticalServices = @(
            "WinRM",
            "Spooler",
            "W32Time",
            "EventLog"
        )

        foreach ($service in $CriticalServices){
            $CurrentService = Get-Service -Name $service
            
            Write-Host "=== Checking Status of $service and Restarting if needed ==="
            if ($CurrentService.Status -ne "Running"){
                Restart-Service -Name $service -Force
            }
        }
    }

    Get-PSSession | Remove-PSSession
    Write-Host "=== Session closed ===" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Red
}

Write-Host "===================================================" -ForegroundColor Yellow
Write-Host "=== All sessions are closed ===" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Yellow
Get-PSSession