use v6;

my $X = 1;
my $cycle = 0;
my $sum = 0;

# Function to increment the cycle counter
sub increment-cycle() {
    $cycle++;

    # --- Part One ---
    if ($cycle - 20) % 40 == 0 {
        $sum += $X * $cycle;
        # say "X is $X at cycle $cycle";
    }

    # --- Part Two ---
    if abs($X - (($cycle - 1) % 40)) < 2 {
        print "#"
    } else {
        print " "
    }

    if $cycle % 40 == 0 {
        say ""
    }
}

for lines() -> $line {
    # Every instruction takes at least one cycle
    increment-cycle();

    # If the instruction is an / addx n / ...
    if $line ~~ / ^ addx / {
        # ... add one cycle for the addx instruction
        increment-cycle();

        # ... extract the value of n
        my $n = ($line ~~ / '-'?\d+ /);
        
        # ... and add the value of n to the value of X
        $X += $n;
    }
}

# --- Part One ---
say "Sum is $sum";
