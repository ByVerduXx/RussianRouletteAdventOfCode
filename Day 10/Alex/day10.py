def noop():
    return 

def addx(x, dx):
    return x+dx

def add_strength(current_cycle, target_cycles, signal_strength, x):
    if current_cycle in target_cycles:
        signal_strength += x*(current_cycle)
        print(f"Signal strength: {signal_strength} (current cycle: {current_cycle}, x: {x})")
    return signal_strength

def add_cycle(cycles, target_cycles, signal_strength, x):
    cycles += 1
    signal_strength = add_strength(current_cycle, target_cycles, signal_strength, x)
    return cycles,signal_strength

def print_cycle(sprite, current_cycle, x):
    row = current_cycle // len(sprite[0])
    col = (current_cycle % len(sprite[0])) - 1
    # print(f"Row:{row}, Col:{col}, Cycle:{current_cycle}, x:{x}")
    if x<=col+1<=x+2:
        sprite[row] = sprite[row][:col] + "#" + sprite[row][col+1:]
    return sprite

def print_sprite(sprite):
    for i in range(len(sprite)):
        print(sprite[i])

current_cycle = 1
x = 1
target_cycles = [20,60,100,140,180,220]
signal_strength = 0
cycles_per_op = {"noop": 1, "addx": 2}

sprite = [("."*40) for i in range(6)]

console_input = "start"
while (console_input != ""):
    try:
        console_input = input()
        print(console_input)

        split_input = console_input.split(" ")

        for i in range(cycles_per_op[split_input[0]]):
                sprite = print_cycle(sprite, current_cycle, x)
                current_cycle,signal_strength = add_cycle(current_cycle, target_cycles, signal_strength, x)

        if split_input[0] == "noop":
            noop()
        elif split_input[0] == "addx":
            dx = int(split_input[1])
            x = addx(x, dx)
        else:
            print("Unrecognized command.")
            break

    except EOFError:
        break

print(f"Final value of x: {x}, with signal strength {signal_strength}")

print_sprite(sprite)