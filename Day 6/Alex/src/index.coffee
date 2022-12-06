# Import modules
readline = require('readline')

# Ask input from console
input_interface = readline.createInterface({
  input: process.stdin,
  output: process.stdout
})

# Function that checks if there are repeated characters in a string
has_repeated_chars = (string) ->
  # Filter the string looking for repeated characters
  string = string.split('').filter((char, index, array) ->
    # Check if the character is repeated
    if array.indexOf(char) != array.lastIndexOf(char)
      # Return true if it is
      char
    )
  # Return false if there are no repeated characters
  return string.length > 0

first_marker = (string, marker_length) ->
  # Iterate over the string generating a 4 length substring
  for i in [0..string.length - marker_length]
    # Get the substring
    substring = string[i..i + marker_length - 1]
    # Check if the substring is repeated
    if !has_repeated_chars(substring)
      # Return the substring if it is not repeated
      return i+marker_length



# Ask for input
input_interface.question("Enter the string to process: ", (input) ->

  # Print the name
  console.log("The first marker is: #{first_marker(input,14)}")

  # Close the input interface
  input_interface.close()
)