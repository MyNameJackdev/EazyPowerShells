# Infinite loop to continuously display the current date and time
while ($true) {
    # Clear the console screen
    Clear-Host
    
    # Get the current date and time
    $currentDateTime = Get-Date
    
    # Display the current date and time in a formatted string
    Write-Host "Current Date and Time: $($currentDateTime.ToString('F'))"
    
    # Pause for 1 second before the next iteration
    Start-Sleep -Seconds 1
}
