# ======================================================
# Collect Security Information
# ======================================================

$targetIP = "192.168.56.125"
$Credential = Get-Credential

$Session = New-PSSession `
    -ComputerName $targetIP `
    -Credential $Credential


Invoke-Command `
    -Session $Session `
    -ScriptBlock {
        $Defender = Defender\Get-MpComputerStatus
        $Firewall = Get-NetFirewallProfile

        [PSCustomObject]@{
            DefenderEnabled = $Defender.RealTimeProtectionEnabled
            AntivirusEnabled = $Defender.AntivirusEnabled
            FirewallEanbled = $Firewall.Enabled -contains $true
        }


    }

Remove-PSSession $Session