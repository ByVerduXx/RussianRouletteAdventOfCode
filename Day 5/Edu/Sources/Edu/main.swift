// array of arrays of chars
var stacks1: [[Character]] = []
var stacks2: [[Character]] = []
var line: String?
var str: String

// Read the stacks
repeat {
  // Read a line
  line = readLine()

  // The line read is an optional string. Deoptionalize it.
  if line != nil {
    str = line!
  } else {
    str = ""
  }

  // Add the characters to the stacks
  for (i, c) in str.enumerated() {
    let stackIndex: Int = i / 4
    let column: Int = i % 4
    if stackIndex >= stacks1.count {
      stacks1.append([])
    }
    if column == 1 {
      stacks1[stackIndex].append(c)
    }
  }
} while str != ""

// Format the stacks appropriately
for i in 0..<stacks1.count {
  // Remove the stack number from the stack
  stacks1[i].removeLast()

  // Reverse the stack
  stacks1[i].reverse()

  // Remove the spaces from the end of the stack
  while stacks1[i].last! == " " {
    stacks1[i].removeLast()
  }
}

// Clone the stacks
stacks2 = stacks1

// // Print every stack
// for stack in stacks1 {
//   print(stack)
// }
// print()

line = readLine()
while line != nil {
  // Deoptionalize the line
  str = line!
  if str == "" { break }

  // Split the line into an array of substrings
  let splitStr: [String.SubSequence] = str.split(separator: " ")

  // Get the amount from splitStr[1]
  let amount: Int = Int(splitStr[1])!

  // Get the stack1 from splitStr[3]
  let stack1: Int = Int(splitStr[3])! - 1

  // Get the stack2 from splitStr[5]
  let stack2: Int = Int(splitStr[5])! - 1

  // --- Part One ---
  // move the amount of cards from stack1 to stack2
  for _ in 0..<amount {
    stacks1[stack2].append(stacks1[stack1].removeLast())
  }

  // --- Part Two ---
  // move the amount of cards from stack1 to stack2 using a temporary stack
  var tempStack: [Character] = []
  for _ in 0..<amount {
    tempStack.append(stacks2[stack1].removeLast())
  }
  for _ in 0..<amount {
    stacks2[stack2].append(tempStack.removeLast())
  }

  // Read the next line
  line = readLine()
}

// --- Part One ---
// Print the last element of every stack
print("--- Part One ---")
for stack in stacks1 {
  print(stack.last!, terminator: "")
}
print()

// --- Part Two ---
// Print the last element of every stack
print("--- Part Two ---")
for stack in stacks2 {
  print(stack.last!, terminator: "")
}
print()
