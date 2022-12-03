const readline = require('node:readline');
const { stdin: input, stdout: output } = require('node:process');

const rl = readline.createInterface({ input, output, terminal: false });

// --- Part One ---
let priorities = [];

// --- Part Two ---
let lines = [];
let priorities2 = [];

rl.on('line', (input) => {
  // Remove trailing newline
  if (input[input.length - 1] === '\n') {
    input = input.slice(0, -1);
  }

  // --- Part One ---
  // Split input in half
  let first = input.slice(0, input.length / 2);
  let second = input.slice(input.length / 2);

  // check for elements in both first and second
  let common = [...first].filter((element) => second.includes(element));

  // remove dupes from common
  common = [...new Set(common)];
  
  // add elements in common to priorities
  priorities = priorities.concat(common);

  // --- Part Two ---
  // add input to lines
  lines.push(input);

  // if lines has 3 elements
  if (lines.length === 3) {
    // extract first, second, and third
    let [first, second, third] = lines;

    // reset lines
    lines = [];

    // check for elements in all lines
    let common = [...first].filter((element) => second.includes(element) && third.includes(element));

    // remove dupes from common
    common = [...new Set(common)];

    // add elements in common to priorities
    priorities2 = priorities2.concat(common);
  }
});

rl.on('close', () => {
  // --- Part One ---
  // map elements in priorities [a-z] to 1-26 and [A-Z] to 27-52
  priorities = priorities.map((element) => {
    if (element.charCodeAt(0) > 96) { // lowercase
      return element.charCodeAt(0) - 96;
    } else { // uppercase
      return element.charCodeAt(0) - 64 + 26;
    }
  });

  // sum the priorities
  sum = priorities.reduce((a, b) => a + b, 0);

  // print the sum
  console.log(sum);

  // --- Part Two ---
  // map elements in priorities [a-z] to 1-26 and [A-Z] to 27-52
  priorities2 = priorities2.map((element) => {
    if (element.charCodeAt(0) > 96) { // lowercase
      return element.charCodeAt(0) - 96;
    } else { // uppercase
      return element.charCodeAt(0) - 64 + 26;
    }
  });

  // sum the priorities
  sum = priorities2.reduce((a, b) => a + b, 0);
  
  // print the sum
  console.log(sum);
  
  // good bye!
  process.exit(0);
});
