# Function to calculate the matrix and update the buffer
function CalculateMatrix {
    param([int]$pos, [char]$letter)
    
    # Get the maximum width and height of the console window
    [int]$width = $rui.MaxWindowSize.Width
    [int]$height = $rui.MaxWindowSize.Height
    
    # Initialize the y-coordinate
    [int]$y = 0
    
    # Loop through each x-coordinate in the width of the console
    for ([int]$x = 0; $x -lt $width; $x++) {
        if ($x -eq $pos) {
            # If the current x-coordinate matches the position, set the buffer at (y, x) to the letter
            $global:buf[$y * $width + $x] = $letter
        } else {
            # Otherwise, set the buffer at (y, x) to a space character
            $global:buf[$y * $width + $x] = [char]32
        }
    }
    
    # Loop through each y-coordinate from bottom to top
    for ([int]$y = ($height - 1); $y -gt 0; $y--) { 
        for ([int]$x = 0; $x -lt $width; $x++) { 
            # Shift the buffer content from the row above to the current row
            $global:buf[$y * $width + $x] = $global:buf[($y - 1) * $width + $x]
        } 
    }
}

# Function to get a random character or number
function NextCharacter {
    # Generate a random ASCII value for characters and numbers
    $asciiValue = $global:generator.Next(33, 127)
    return [char]$asciiValue
}

# Get the UI and raw UI objects
$ui = (Get-Host).ui
$rui = $ui.rawui

# Initialize the buffer with spaces
$buffer0 = ""
1..($rui.MaxWindowSize.Width * $rui.MaxWindowSize.Height) | foreach { $buffer0 += " " }
$global:buf = $buffer0.ToCharArray()

# Create a new Random object
$global:generator = New-Object System.Random

# Generate random initial positions and speeds for 50 lines
$global:positions = @(1..50 | ForEach-Object { [int]$global:generator.next(0, $rui.MaxWindowSize.Width) })
$global:speeds = @(1..50 | ForEach-Object { [int]$global:generator.next(5, 50) })

# Infinite loop to update the matrix
while ($true) {
    for ($i = 0; $i -lt 50; $i++) {
        # Get a random character or number
        $letter = NextCharacter
        
        # Calculate the matrix with the current position and letter
        CalculateMatrix $global:positions[$i] $letter
        
        # Update the position for the next iteration
        $global:positions[$i] = [int]$global:generator.next(0, $rui.MaxWindowSize.Width)
        
        # Set the cursor position to the top-left corner
        [console]::SetCursorPosition(0,0)
        
        # Create a string from the buffer and display it
        [string]$screen = New-Object system.string($global:buf, 0, $global:buf.Length)
        Write-Host -foreground green $screen -noNewline
        
        # Pause for a shorter time to increase density
        Start-Sleep -milliseconds ($global:speeds[$i] / 5)
    }
}

# Exit the script with a success codes
exit 0 # success
