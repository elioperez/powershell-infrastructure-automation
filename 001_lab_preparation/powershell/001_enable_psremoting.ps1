Enable-PSRemoting -Force -SkipNetworkProfileCheck -Verb 
winrm enumerate winrm/config/listener
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force
get-Item WSMan:\localhost\Client\TrustedHosts
Get-Service WinRM