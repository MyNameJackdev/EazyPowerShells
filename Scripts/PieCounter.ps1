# Store the value of PI as a string
$pi = [math]::PI.ToString()
# Create a new Random object
$random = New-Object System.Random
# Infinite loop
while ($true) {
    # Iterate over each character in the PI string
    foreach ($digit in $pi.ToCharArray()) {
        # Generate a random number of spaces before the digit (between 5 and 20)
        $beforeSpaces = " " * $random.Next(5, 20)
        # Generate a random number of spaces after the digit (between 5 and 20)
        $afterSpaces = " " * $random.Next(5, 20)
        # Output the digit with random spaces before and after it
        Write-Output "$beforeSpaces$digit$afterSpaces"
        # Pause for 1 millisecond
        Start-Sleep -Milliseconds 1
    }
}
