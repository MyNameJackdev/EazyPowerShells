# Countdown with the option to cancel
for ($i = 5; $i -gt 0; $i--) {
    Write-Host "Locking computer in $i seconds. Press Ctrl+C to cancel."
    Start-Sleep -Seconds 1
}

# Lock the computer
rundll32.exe user32.dll,LockWorkStation
