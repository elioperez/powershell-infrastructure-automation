# =======================================
# Collect Disk Information
# =======================================

$TargetIP = "192.168.56.125"
$Credential = Get-Credential

$Session = New-PSSession `
    -ComputerName $TargetIP `
    -Credential $Credential

Write-Host "======= Disk Information =======" -ForegroundColor Cyan
Invoke-Command `
    -Session $Session `
    -ScriptBlock {
        Get-CimInstance Win32_LogicalDisk |
            where DriveType -eq 3 | 
            Select-Object DeviceID,
            @{N="FreeGB"; E={[System.Math]::Round($_.FreeSpace/1GB,2)}},
            @{N="TotalGB"; E={[System.Math]::Round($_.Size/1GB,2)}}

    }

#Remove Session
Remove-PSSession $Session
Write-Host "Session is Closed..."
Get-PSSession