# Create empty array of ints
$actual_calory = 0
$calories = @()

# Read input from stdin
foreach ($i in $input) {
    # If input is empty
    if ($i) {
        $actual_calory += $i
        #Write-Host "Adding $i..."
    } else {
        Write-Host "Total calories: $actual_calory"
        $calories += $actual_calory
        $actual_calory = 0
    }
}

# Sort an array
$calories = $calories | Sort-Object

# Get the Last element
$greater_calory = $calories[-1]

Write-Host "Greater calories: $greater_calory"

# Write the 3 last elements and their sum
Write-Host "Last 3 days: $($calories[-3..-1])"
$total_last_3_days = $($calories[-3..-1] | Measure-Object -Sum).Sum
Write-Host "Sum of last 3 days: $($($calories[-3..-1] | Measure-Object -Sum).Sum)"