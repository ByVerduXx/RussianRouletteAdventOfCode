#aquí leería el input, pero me da pereza hacerlo.
input = ''
elves_inventories = input.split("\n")
elves = []
total = 0
for elve_inventory in elves_inventories:
    if elve_inventory == "":
        elves.append(total)
        total = 0
    else:
        total += int(elve_inventory)
elves.sort(reverse=True)
print(elves[0])
print(sum(elves[0:3]))