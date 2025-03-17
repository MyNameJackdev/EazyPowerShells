# Function to check if running as administrator
function Test-Administrator {
    # Get the current user and check if they are an administrator
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        # If not an administrator, display an error message and exit the script
        Write-Error "You need to run this script as an administrator."
        exit
    }
}

# Function to list all installed applications
function Get-InstalledApplications {
    # Get properties of installed applications from the registry and select specific fields
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
}

# Function to uninstall an application
function Uninstall-Application {
    param (
        # Parameter to accept the application name to uninstall
        [string]$appName
    )

    # Get the application details from the registry based on the provided name
    $app = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
           Where-Object { $_.DisplayName -like "*$appName*" }

    # If the application is not found, display a message and return
    if ($null -eq $app) {
        Write-Host "Application '$appName' not found."
        return
    }

    # Get the uninstall string from the application details
    $uninstallString = $app.UninstallString
    # If the uninstall string is not found, display a message and return
    if ($null -eq $uninstallString) {
        Write-Host "Uninstall string for '$appName' not found."
        return
    }

    # Prompt the user for confirmation before uninstalling
    $confirmation = Read-Host "Are you sure you want to uninstall '$appName'? (yes/no)"
    # If the user confirms, run the uninstall command
    if ($confirmation -eq "yes") {
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c $uninstallString" -Wait
        Write-Host "Application '$appName' has been uninstalled."
    } else {
        # If the user cancels, display a cancellation message
        Write-Host "Uninstallation of '$appName' cancelled."
    }
}

# Main script execution
Test-Administrator # Check if running as administrator

Write-Host "Installed Applications:" # Display a header
# List installed applications and format the output as a table
Get-InstalledApplications | Format-Table -AutoSize

# Prompt the user to enter the name of the application to uninstall
$appName = Read-Host "Enter the name of the application you want to uninstall"
# If the user provides an application name, call the uninstall function
if ($appName) {
    Uninstall-Application -appName $appName
}
