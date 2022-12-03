# Primera parte
let list = readfile('sample.in')

let scoreboard = {}
let scoreboard['X'] = {"A":4,"B":1,"C":7}
let scoreboard['Y'] = {"A":8,"B":5,"C":2}
let scoreboard['Z'] = {"A":3,"B":9,"C":6}

let sum = 0

for line in list
  let elements = split(line)
  let sum += scoreboard[elements[1]][elements[0]]
endfor

echo sum

# Segunda parte
let scoreboard['X'] = {"A":3,"B":1,"C":2}
let scoreboard['Y'] = {"A":4,"B":5,"C":6}
let scoreboard['Z'] = {"A":8,"B":9,"C":7}

let sum = 0

for line in list
  let elements = split(line)
  let sum += scoreboard[elements[1]][elements[0]]
endfor

echo sum
