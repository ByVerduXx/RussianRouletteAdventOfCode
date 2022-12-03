
// Read the file input.txt
def file = new File('input.txt')

// Variable with the points
def points1 = 0
// Read the file line by line
file.eachLine { line ->
    // Split the line by spaces
    def words = line.split(' ')
    // A is 0, B is 1, C is 2, D is 3
    def j1 = words[0]
    def j2 = words[1]
    if (j2 == 'X') {
        points += 1
        if (j1 == 'A') {
            points += 3
        } else if (j1 == 'B') {
            points += 0
        } else if (j1 == 'C') {
            points += 6
        }
    } else if (j2 == 'Y') {
        points += 2
        if (j1 == 'A') {
            points += 6
        } else if (j1 == 'B') {
            points += 3
        } else if (j1 == 'C') {
            points += 0
        }
    } else if (j2 == 'Z') {
        points += 3
        if (j1 == 'A') {
            points += 0
        } else if (j1 == 'B') {
            points += 6
        } else if (j1 == 'C') {
            points += 3
        }
    }
}

// Print the points
print points1 +  '\n'

def points2 = 0

def file2 = new File('input.txt')

file2.eachLine { line ->
    def words = line.split(' ')
    // A is 0, B is 1, C is 2, D is 3
    def j1 = words[0]
    def j2 = words[1]

    if (j2 == 'X') {
        if (j1 == 'A') {
            points2 += 3
        } else if (j1 == 'B') {
            points2 += 1
        } else if (j1 == 'C') {
            points2 += 2
        }

    } else if (j2 == 'Y') {
        points2 += 3
        if (j1 == 'A') {
            points2 += 1
        } else if (j1 == 'B') {
            points2 += 2
        } else if (j1 == 'C') {
            points2 += 3
        }
    } else if (j2 == 'Z') {
        points2 += 6
        if (j1 == 'A') {
            points2 += 2
        } else if (j1 == 'B') {
            points2 += 3
        } else if (j1 == 'C') {
            points2 += 1
        }
    }
}

print points2 +  '\n'