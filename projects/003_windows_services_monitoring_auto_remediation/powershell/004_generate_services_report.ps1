# ==========================================================
# Service Health Report
# ==========================================================

$TargetIP = Get-Content .\computers.txt
$Credential = Get-Credential

foreach ($pc in $TargetIP){
    Write-Host "=== Session Established in $pc === " -ForegroundColor Cyan

    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential

    $Report = Invoke-Command `
                -Session $Session `
                -ScriptBlock {

                $CriticalServices = @(
                    "WinRM",
                    "Spooler",
                    "W32Time",
                    "EventLog"
                )

                foreach ($service in $CriticalServices){
                    Get-Service -Name $service | Select-Object Name,Status,StartType
                }
                }
            
    $Report |
    Export-Csv `
    "D:\powershell-infrastructure-automation\projects\003_windows_services_monitoring_auto_remediation\output\$($pc)_services_report.csv" `
    -NoTypeInformation

    $Report |
    ConvertTo-Json |
    Out-File `
    "D:\powershell-infrastructure-automation\projects\003_windows_services_monitoring_auto_remediation\output\$($pc)_services_report.json" `

    $Report | 
    Out-File `
    "D:\powershell-infrastructure-automation\projects\003_windows_services_monitoring_auto_remediation\output\$($pc)_services_report.txt"
    
    Get-PSSession | Remove-PSSession
    Write-Host "=== Session Closed ===" -ForegroundColor Cyan
    Write-Host "======================" -ForegroundColor Red
}

Write-Host "================================================" -ForegroundColor Yellow
Write-Host "All Sessions Are Closed...!" -ForegroundColor Cyan
Get-PSSession
Write-Host "================================================" -ForegroundColor Yellow
