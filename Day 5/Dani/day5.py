# read lines from input.in

# open file
f = open("Day 5/Dani/input.in", "r")
# read lines
lines = f.readlines()
# close file
f.close()
# remove new line characters
lines = [line.replace("\n", "") for line in lines]

crates = []
# [[number,from,to],...]]]
instructions = []

aux = True
for line in lines:
    if line == "":
        aux = False
        crates.pop()  # quitamos la linea de numeros
        continue
    if aux:
        replaced = line.replace("[", " ").replace("]", " ")
        crates.append(replaced)
    else:
        parsed = line.split(" ")[1::2]
        integers = [int(i) for i in parsed]
        instructions.append(integers)

stacks = [[] for col in range(1) for row in range(9)]
stacks2 = [[] for col in range(1) for row in range(9)]

for i in range(len(crates)):
    for j in range(9):
        caracter = crates[i][j * 4 + 1]
        if caracter != " ":
            stacks[j].insert(0, caracter)
            stacks2[j].insert(0, caracter)

for i in range(len(instructions)):
    for _ in range(instructions[i][0]):
        stacks[instructions[i][2] -
               1].append(stacks[instructions[i][1] - 1].pop())

solution = ""
for i in range(9):
    solution += stacks[i][len(stacks[i]) - 1]

print(solution)

# Part 2
for i in range(len(instructions)):
    aux = []
    for j in range(instructions[i][0]):
        aux.append(stacks2[instructions[i][1] - 1].pop())
    for _ in range(len(aux)):
        stacks2[instructions[i][2] - 1].append(aux.pop())

solution2 = ""
for i in range(9):
    solution2 += stacks2[i][len(stacks2[i]) - 1]

print(solution2)
