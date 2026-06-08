# ========================================
# Generate Health Report
# ========================================

$Targets = Get-Content .\computers.txt
$Credential = Get-Credential

foreach($pc in $Targets){

    

    Write-Host "============= Reporting $pc =============="

    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential

    Invoke-Command `
        -Session $Session `
        -ScriptBlock {
            
            $ReportName = "health_report_$using:pc"

            $Report = [PSCustomObject]@{
            AuditDate = Get-Date
            Target = $Using:pc
            Status = "Healthy"
            }
            

            Write-Host " === Generating Report *.csv ==="
            $Report |
                Export-Csv `
                -Path "C:\$ReportName.csv" `
                -NoTypeInformation

            Write-Host " === Generating Report *.jason ==="
            $Report |
                ConvertTo-Json | 
                Out-File `
                "C:\$ReportName.json"
    
            Write-Host " === Generating Report *.txt ==="
            $Report |
                Out-File `
                "C:\$ReportName.txt"
             

            ls \\$using:pc\c$
    # Centralize Reports to 192.168.56.127 machine
    Write-Host "Copying Reports from $using:pc to --> 192.168.56.127"
    Copy-Item "\\$using:pc\c$\$ReportName.*" -Destination "\\192.168.56.127\d$\powershell-infrastructure-automation\projects\002_remote_windows_health_audit\output\"

    }
}
Get-PSSession | Remove-PSSession
Get-PSSession
ls "D:\powershell-infrastructure-automation\projects\002_remote_windows_health_audit\output"
