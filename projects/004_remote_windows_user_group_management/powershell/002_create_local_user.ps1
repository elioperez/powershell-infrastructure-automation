# ==========================================================
# Create Local User in Multiple Computers
# ==========================================================

# Define Computer Targets and Credentials
$TargetsIP = Get-Content .\computers.txt
$Credential = Get-Credential

# Iterate to Each Computer : Establish Session and Create Local User:
foreach ($pc in $TargetsIP){
    Write-Host "=== $pc ===" -ForegroundColor Cyan

    $Session = New-PSSession `
        -ComputerName $pc `
        -Credential $Credential

    Invoke-Command `
        -Session $Session `
        -ScriptBlock {

            $Password = ConvertTo-SecureString `
                "Password123" `
                -AsPlainText `
                -Force

            New-LocalUser `
            -Name "HelpDeskUser" `
            -Password $Password `
            -FullName "Help Desk User" `
            -Description "Help Desk User Support"

            Get-LocalUser | Where-Object {$_.name -eq 'HelpDeskUser'}

        }
Remove-PSSession $Session
Write-Host "========================================" -ForegroundColor Red
}

Write-Host "========================================" -ForegroundColor Yellow
Get-PSSession
Write-Host "=== All Sessions Are Closed...! ===" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Yellow