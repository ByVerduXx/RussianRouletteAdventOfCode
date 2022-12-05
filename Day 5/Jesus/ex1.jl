# Read the file input.txt

# Open the file
f = open("input.txt")

# Read the file
data = read(f, String)

# Close the file
close(f)

# Print the data

# Save linesIni until the line correspond to the regex (\s+(\d\s+)+)
# Save the linesIni in a vector
linesIni = []
instrucciones = []
# lim = 1
# aux = 1
# init a boolean
b = false
for line in eachline("input.txt")
    # if occursin(r"(\s+(\d\s+)+)", line)
    
    if (line == "")
        global b = true
    end
    # aux = aux + 1
    if (! b)
        push!(linesIni, line)
    else
        push!(instrucciones, line)
    end
end

# Print the length of each line
# Get the length of the first line
nelems = floor(Int, (length(linesIni[1]) + 1)/4)
println("Number of elements: ", nelems)

# Create an array of nelems stacks
stacks = [Char[] for i in 1:nelems]

for line in linesIni
    for i in 0:nelems-1
        elem = line[4*i+2]
        if elem != ' '
            # println("Pushing ", elem, " to stack ", i+1)
            push!(stacks[i+1], elem)
        end
    end
end

# Invert the stacks
for i in 1:nelems
    stacks[i] = reverse(stacks[i])
end

println("Stacks: ", stacks)

# Remove the first element of the instruction (empty space)
instrucciones = instrucciones[2:end]

# Part 1 

# for instr in instrucciones
#     # Get the numbers with the regex "move [0-9]+ from [0-9]+ to [0-9]+"

#     a, b, c = match(r"move ([0-9]+) from ([0-9]+) to ([0-9]+)", instr)
#     println("a: ", a, " b: ", b, " c: ", c)

#     # move a elements from the stack b to the stack c
#     for i in 1:parse(Int, a)
#         println("Pushing ", stacks[parse(Int, b)][end], " to stack ", c)
#         push!(stacks[parse(Int, c)], pop!(stacks[parse(Int, b)]))
#     end
# end

# Part 2

for instr in instrucciones
    # Get the numbers with the regex "move [0-9]+ from [0-9]+ to [0-9]+"

    a, b, c = match(r"move ([0-9]+) from ([0-9]+) to ([0-9]+)", instr)
    println("a: ", a, " b: ", b, " c: ", c)

    # move the last a elemets of the stack b to the stack c
    aux = []
    for i in 1:parse(Int, a)
        push!(aux, pop!(stacks[parse(Int, b)]))
    end
    for i in 1:parse(Int, a)
        push!(stacks[parse(Int, c)], aux[end])
        pop!(aux)
    end
end

# Print the elements from the top of eaxh stack
for i in 1:nelems
    print(last(stacks[i]))
end
println()