#==================================================
#Create remote session
#==================================================

$targetIP = "192.168.56.125"
$Credential = Get-Credential

$Session = New-PSSession `
    -ComputerName $targetIP `
    -Credential $Credential

$Session
