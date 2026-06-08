# ==================================
# Collect Local Administrators
# ==================================

$TargetIP = "192.168.56.125"
$Credential = Get-Credential

$Session = New-PSSession `
    -ComputerName $TargetIP `
    -Credential $Credential

Write-Host "========= Collecting Local Admins ===========" -ForegroundColor Cyan
Invoke-Command `
    -Session $Session `
    -ScriptBlock {
        Get-LocalGroupMember Administrators
    }

# Remove Session
Remove-PSSession $Session
Write-Host "Session is Closed...!"
Get-PSSession
