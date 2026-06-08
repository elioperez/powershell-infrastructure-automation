# ==================================================
# Collect System INformation
# ==================================================

$TargetIp = "192.168.56.125"
$Credential = Get-Credential

$Session = New-PSSession `
    -ComputerName $TargetIp `
    -Credential $Credential

Invoke-Command `
    -Session $Session `
    -ScriptBlock {
        $OS = Get-CimInstance Win32_OperatingSystem 
        $CPU = Get-CimInstance Win32_Processor

        [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            OperatingSystem = $OS.Caption
            LastBootTime = $OS.LastBootUpTime
            CPU = $CPU.Name
            LoggedUser = $env:USERNAME
        }
    }

Remove-PSSession $Session