# Define Target(s)
$targetIP = "192.168.56.125"

# Prompt for Credentials
$credential = Get-Credential


# Create session
$session = New-PSSession `
    -ComputerName $targetIP `
    -Credential $credential 
     
    

# Display session information
$session
