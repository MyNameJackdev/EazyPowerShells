# Ensure necessary modules are imported
Import-Module CimCmdlets

# Retrieve system information
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$cpu = Get-CimInstance -ClassName Win32_Processor
$memory = Get-CimInstance -ClassName Win32_PhysicalMemory
$bios = Get-CimInstance -ClassName Win32_BIOS

# Display system information
Write-Host "System Information" -ForegroundColor Green
Write-Host "===================" -ForegroundColor Green
if ($os) {
    Write-Host "Operating System: $($os.Caption) $($os.OSArchitecture)"  # Display OS name and architecture
    Write-Host "Version: $($os.Version)"  # Display OS version
    Write-Host "Manufacturer: $($os.Manufacturer)"  # Display OS manufacturer
    Write-Host "Computer Name: $($os.CSName)"  # Display computer name
}

Write-Host "CPU Information" -ForegroundColor Green
Write-Host "==============="
if ($cpu) {
    Write-Host "Name: $($cpu.Name)"  # Display CPU name
    Write-Host "Manufacturer: $($cpu.Manufacturer)"  # Display CPU manufacturer
    Write-Host "Number of Cores: $($cpu.NumberOfCores)"  # Display number of CPU cores
    Write-Host "Number of Logical Processors: $($cpu.NumberOfLogicalProcessors)"  # Display number of logical processors
}

Write-Host "Memory Information" -ForegroundColor Green
Write-Host "=================="
if ($memory) {
    $totalMemory = ($memory | Measure-Object -Property Capacity -Sum).Sum  # Calculate total physical memory
    Write-Host "Total Physical Memory: $([math]::round($totalMemory / 1GB, 2)) GB"  # Display total physical memory in GB
}

Write-Host "BIOS Information" -ForegroundColor Green
Write-Host "================"
if ($bios) {
    Write-Host "Manufacturer: $($bios.Manufacturer)"  # Display BIOS manufacturer
    Write-Host "Version: $($bios.SMBIOSBIOSVersion)"  # Display BIOS version
}