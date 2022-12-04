# --- Day 4: Camp Cleanup ---

# --- Part One ---
function Interval-Equals {
  param([Parameter(Mandatory=$true)][int[]]$Int1,[Parameter(Mandatory=$true)][int[]]$Int2)
  return ($Int1[0] -eq $Int2[0] -and $Int1[1] -eq $Int2[1])
}

function Interval-Is-Empty {
  param([Parameter(Mandatory=$true)][int[]]$Array)
  return $Array[1] -lt $Array[0]
}

$fullOverlaps = 0
$partialOverlaps = 0

# Read input from stdin
foreach ($i in $input) {
  # If input is empty
  if ($i) {
    # Write-Host "Processing $i..."

    # Get first and second set
    $first = $i.Split(",")[0].Split("-")
    $second = $i.Split(",")[1].Split("-")

    # Intersection between first and second
    $intersect = @()
    $intersect += [Math]::Max($first[0], $second[0])
    $intersect += [Math]::Min($first[1], $second[1])

    # Check if the intersection is first or second
    if ((Interval-Equals $intersect $first) -or (Interval-Equals $intersect $second)) {
      # Write-Host "$i has a full overlap -> $intersect"
      $fullOverlaps += 1
    } elseif (Interval-Is-Empty $intersect) {
      # Write-Host "$i has no overlap -> $intersect"
    } else {
      # Write-Host "$i has a partial overlap -> $intersect"
      $partialOverlaps += 1
    }
  }
}

Write-Host "Total full overlaps: $fullOverlaps"
Write-Host "Total partial overlaps: $partialOverlaps"
Write-Host "Total overlaps: $($fullOverlaps + $partialOverlaps)"
