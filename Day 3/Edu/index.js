const readline = require('node:readline');
const { stdin: input, stdout: output } = require('node:process');

const rl = readline.createInterface({ input, output, terminal: false });

// --- Part One ---
let priorities = [];

// --- Part Two ---
let lines = [];
let priorities2 = [];

rl.on('line', (input) => {
  if (input[input.length - 1] === '\n') {
    input = input.slice(0, -1);
  }

  // --- Part One ---
  let first = input.slice(0, input.length / 2);
  let second = input.slice(input.length / 2);

  let common = [...first].filter((element) => second.includes(element));
  common = [...new Set(common)];
  priorities = priorities.concat(common);

  // --- Part Two ---
  lines.push(input);

  if (lines.length === 3) {
    let [first, second, third] = lines;
    lines = [];

    let common = [...first].filter((element) => second.includes(element) && third.includes(element));
    common = [...new Set(common)];
    priorities2 = priorities2.concat(common);
  }
});

rl.on('close', () => {
  // --- Part One ---
  priorities = priorities.map((element) => {
    if (element.charCodeAt(0) > 96) {
      return element.charCodeAt(0) - 96;
    } else {
      return element.charCodeAt(0) - 64 + 26;
    }
  });
  sum = priorities.reduce((a, b) => a + b, 0);
  console.log(sum);

  // --- Part Two ---
  priorities2 = priorities2.map((element) => {
    if (element.charCodeAt(0) > 96) {
      return element.charCodeAt(0) - 96;
    } else {
      return element.charCodeAt(0) - 64 + 26;
    }
  });
  sum = priorities2.reduce((a, b) => a + b, 0);
  console.log(sum);
  
  process.exit(0);
});
