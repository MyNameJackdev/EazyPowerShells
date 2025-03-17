# Countdown with the option to cancel
# you can adjust the amount of time to wait be changing the 5 to a different value etc 10, 15, 20 etc
for ($i = 5; $i -gt 0; $i--) {
    Write-Host "Restarting computer in $i seconds. Press Ctrl+C to cancel."
    Start-Sleep -Seconds 1
}

# Restart the computer
Restart-Computer -Force
