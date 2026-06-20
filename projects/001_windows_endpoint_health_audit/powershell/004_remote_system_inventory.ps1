# Collect System Information

# Define Target
$targetIP = "192.168.56.125"

# Get Credentials
$credential = Get-Credential

# Create Session
$Session = New-PSSession `
    -ComputerName $targetIP `
    -Credential $credential
    Write-Host " ======= Connecting to remote computer =========" -ForegroundColor Cyan

# Collect Information System
Invoke-Command -Session $Session -ScriptBlock {
    $OS = Get-CimInstance Win32_OperatingSystem

    $CPU = Get-CimInstance Win32_Processor

    $Disk = Get-CimInstance Win32_LogicalDisk | 
        Where-Object DeviceID -eq  "C:"

    [PSCustomObject]@{
        Hostname = $env:COMPUTERNAME
        OperatingSystem = $OS.Caption
        CPU = $CPU.Name
        FreeDisk = [System.Math]::Round($Disk.FreeSpace / 1GB, 
        2)
        TotalRAMGB = [System.Math]::Round($OS.TotalVirtualMemorySize / 1MB, 2 )
        LastBoot = $OS.LastBootUpTime
    }

}

# Close Session
Remove-PSSession  $Session