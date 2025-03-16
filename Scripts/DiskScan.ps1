# Check if the script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an administrator." -ForegroundColor Red
    Exit 1
}

# Scan the C: drive for errors
Write-Host "Scanning the C: drive for errors..." -ForegroundColor Yellow
chkdsk C:

# Check for corrupt Windows system files
Write-Host "Checking for corrupt Windows system files..." -ForegroundColor Yellow
sfc /scannow

Write-Host "Scans completed Please review the output above for more details." -ForegroundColor Green

# Ask the user if they want to exit the application
Write-Host "Do you want to exit the application? (Yes/No)" -ForegroundColor Cyan

do {
    $response = Read-Host "Enter your choice"
    switch ($response.ToLower()) {
        "yes" {
            Write-Host "Exiting the application. Goodbye!" -ForegroundColor Green
            exit
        }
        "no" {
            Write-Host "Continuing with the script. You can manually close it when you're ready." -ForegroundColor Yellow
            break
        }
        default {
            Write-Host "Invalid response. Please enter 'Yes' or 'No'." -ForegroundColor Red
        }
    }
} while ($true)