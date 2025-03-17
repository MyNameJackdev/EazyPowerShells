# Function to add two numbers
function Add($a, $b) {
    return $a + $b  # Return the sum of $a and $b
}

# Function to subtract two numbers
function Subtract($a, $b) {
    return $a - $b  # Return the difference of $a and $b
}

# Function to multiply two numbers
function Multiply($a, $b) {
    return $a * $b  # Return the product of $a and $b
}

# Function to divide two numbers
function Divide($a, $b) {
    if ($b -eq 0) {  # Check if $b is zero
        Write-Host "Error: Division by zero is not allowed."  # Print error message
        return $null  # Return null to indicate error
    }
    return $a / $b  # Return the quotient of $a and $b
}

# Function to perform the calculation
function Calculate($operation, $a, $b) {
    switch ($operation) {  # Switch based on the operation
        'add' { return Add $a $b }  # Call Add function
        'subtract' { return Subtract $a $b }  # Call Subtract function
        'multiply' { return Multiply $a $b }  # Call Multiply function
        'divide' { return Divide $a $b }  # Call Divide function
        default {  # If operation is not recognized
            Write-Host "Invalid operation"  # Print error message
            return $null  # Return null to indicate error
        }
    }
}

# Main loop
while ($true) {
    # Prompt the user for input
    $operation = Read-Host "Enter operation (add, subtract, multiply, divide) or 'exit' to quit"
    CheckExit $operation  # Check if 'j' is pressed to exit
    if ($operation -eq 'exit') { break }  # Exit the loop if the user enters 'exit'

    $a = [double](Read-Host "Enter the first number")  # Read the first number and convert to double
    $b = [double](Read-Host "Enter the second number")  # Read the second number and convert to double

    # Perform the calculation
    $result = Calculate $operation $a $b  # Call the Calculate function

    # Display the result
    if ($result -ne $null) {  # Check if the result is not null
        Write-Host "Result: $result"  # Print the result
    }
}
