use v6;

sub chebyshev(@a, @b) {
  my $max = 0;
  my @c = @a Z @b;
  for @c -> ($x, $y) {
    if (abs($x - $y) > $max) {
      $max = abs($x - $y);
    }
  }
  $max;
}

sub plot(@H, @T, @map) {
  for @map.reverse.kv -> $i, @row {
    for @row.kv -> $j, $cell {
      if (@H[0] == (@map.elems - $i - 1) && @H[1] == $j) {
        print "H";
      } else {
        my $found = False;
        for 0 .. (@T.elems-1) -> $k {
          my $t = @T[$k];
          if ($t[0] == (@map.elems - $i - 1) && $t[1] == $j) {
            print "", $k+1;
            $found = True;
            last;
          }
        }
        if (!$found) {
          print ".";
        }
      }
    }
    say "";
  }
}

sub plot2(@map) {
  for @map.reverse.kv -> $i, @row {
    for @row.kv -> $j, $cell {
      if ($cell > 0) {
        print "#";
      } else {
        print ".";
      }
    }
    say "";
  }
}

sub move-tail($H, @T, @map) {
  # Move the tail towards the head if they're not next to each other
  my $t = @T.pop;
  while (chebyshev($H, $t) > 1) {
    # Move along the $i-th axis
    for 0 .. ($t.elems-1) -> $i {
      if ($t[$i] < $H[$i]) {
        $t[$i]++;
      } elsif ($t[$i] > $H[$i]) {
        $t[$i]--;
      }
    }
    
    # Update the map only with the last tail segment
    if (@T.elems == 0) {
      @map[$t[0]][$t[1]]++;
    }
    # Recursively move the rest of the tail
    else {
      move-tail($t, @T, @map);
    }
  }

  # Reconstruct the tail
  @T.push($t);
}

my @H = [0, 0];
# --- Part One ---
# my @T = @[[0, 0] xx 1];
# --- Part Two ---
my @T = @[[0, 0] xx 9];
my @map = [[1],];

for lines() -> $line {
  # Move the head
  if $line ~~ / ^R / {
    @H[1] += ($line ~~ / '-'?\d+ /);
  } elsif $line ~~ / ^D / {
    @H[0] -= ($line ~~ / '-'?\d+ /);
  } elsif $line ~~ / ^U / {
    @H[0] += ($line ~~ / '-'?\d+ /);
  } elsif $line ~~ / ^L / {
    @H[1] -= ($line ~~ / '-'?\d+ /);
  }

  # If we've moved off the map, extend it
  while (@map.elems <= @H[0]) {
    @map.push([0 xx @map[0].elems]);
  }
  while (@H[0] < 0) {
    @map = @map.reverse;
    @map.push([0 xx @map[0].elems]);
    @map = @map.reverse;
    @H[0]++;
    for 0..@T.elems-1 -> $i {
      @T[$i][0] += 1;
    }
  }
  while (@map[0].elems <= @H[1]) {
    @map = [Z] @map;
    @map.push([0 xx @map[0].elems]);
    @map = [Z] @map;
  }
  while (@H[1] < 0) {
    @map = [Z] @map;
    @map = @map.reverse;
    @map.push([0 xx @map[0].elems]);
    @map = @map.reverse;
    @map = [Z] @map;
    @H[1]++;
    for 0..@T.elems-1 -> $i {
      @T[$i][1] += 1;
    }
  }

  # Move the tail
  move-tail(@H, @T, @map);
  
  # # Plot the map
  # say "T: ", @T, " H: ", @H;
  # plot(@H, @T, @map);
  # say "---";
}

plot2(@map);
say [+] @map.map: { [+] $_.map: { $_ > 0 } };
