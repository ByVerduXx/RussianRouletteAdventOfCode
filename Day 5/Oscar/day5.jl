#    [S] [C]         [Z]            
#[F] [J] [P]         [T]     [N]    
#[G] [H] [G] [Q]     [G]     [D]    
#[V] [V] [D] [G] [F] [D]     [V]    
#[R] [B] [F] [N] [N] [Q] [L] [S]    
#[J] [M] [M] [P] [H] [V] [B] [B] [D]
#[L] [P] [H] [D] [L] [F] [D] [J] [L]
#[D] [T] [V] [M] [J] [N] [F] [M] [G]
# 1   2   3   4   5   6   7   8   9 
a1 = ['D', 'L', 'J', 'R', 'V', 'G', 'F']
a2 = ['T', 'P', 'M', 'B', 'V' ,'H', 'J', 'S']  
a3 = ['V', 'H', 'M', 'F', 'D', 'G', 'P', 'C']
a4 = ['M', 'D', 'P', 'N', 'G', 'Q']
a5 = ['J', 'L', 'H', 'N', 'F']
a6 = ['N', 'F', 'V', 'Q', 'D', 'G', 'T', 'Z']
a7 = ['F','D','B','L']
a8 = ['M', 'J', 'B', 'S', 'V', 'D', 'N']
a9 = ['G', 'L', 'D']
crates = [a1, a2, a3, a4, a5, a6, a7, a8, a9]

# string_a_parsear = "move 3 from 4 to 6"
# parsed = split(string_a_parsear)
# parsed_2 = [parse(Int, parsed[2]), parse(Int, parsed[4]), parse(Int, parsed[6])]
# elementos_pasar = crates[parsed_2[2]][end-parsed_2[1]+1:end]
# print(elementos_pasar)
# append!(crates[parsed_2[3]], elementos_pasar)
# for i in 1:parsed_2[1]
#     pop!(crates[parsed_2[2]])
# end
# for elem in crates
#     print(elem[end])
# end

open("input5.txt") do file
    for l in eachline(file)
        parsed = split(l)
        parsed_2 = [parse(Int64, parsed[2]), parse(Int64, parsed[4]), parse(Int64, parsed[6])]
        for i in 1:parsed_2[1] 
            push!(crates[parsed_2[3]], crates[parsed_2[2]][end])
            pop!(crates[parsed_2[2]])
        end
    end
    for elem in crates
        # print(elem[end])
    end
end

a1 = ['D', 'L', 'J', 'R', 'V', 'G', 'F']
a2 = ['T', 'P', 'M', 'B', 'V' ,'H', 'J', 'S']  
a3 = ['V', 'H', 'M', 'F', 'D', 'G', 'P', 'C']
a4 = ['M', 'D', 'P', 'N', 'G', 'Q']
a5 = ['J', 'L', 'H', 'N', 'F']
a6 = ['N', 'F', 'V', 'Q', 'D', 'G', 'T', 'Z']
a7 = ['F','D','B','L']
a8 = ['M', 'J', 'B', 'S', 'V', 'D', 'N']
a9 = ['G', 'L', 'D']
crates = [a1, a2, a3, a4, a5, a6, a7, a8, a9]

for elem in crates
    println(elem)
end
println("----------------------------------------")

open("input5.txt") do file
    for l in eachline(file)
        parsed = split(l)
        parsed_2 = [parse(Int, parsed[2]), parse(Int, parsed[4]), parse(Int, parsed[6])]
        if length(crates[parsed_2[2]])-parsed_2[1] > 0 
            index = length(crates[parsed_2[2]])-parsed_2[1]+1
        else
            index = 1
        end
        elementos_pasar = crates[parsed_2[2]][index:end]
        append!(crates[parsed_2[3]], elementos_pasar)
        for i in 1:parsed_2[1]
            if length(crates[parsed_2[2]]) > 0
                pop!(crates[parsed_2[2]])
            end
        end
    end
    for elem in crates
        print(elem[end])
    end
end