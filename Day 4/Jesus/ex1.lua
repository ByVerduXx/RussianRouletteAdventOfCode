-- Read the file "input.txt"

-- Open the file
local file = io.open("input.txt", "r")

-- Read the file
local content = file:read("*all")

-- Close the file
file:close()

-- Get the different lines of the file split
local lines = {}
for line in content:gmatch("[^\r\n]+") do
    lines[#lines + 1] = line
end

result = 0

-- Recorrer las lineas y comprobar si un rango está comprendido en otro
-- for i = 1, #lines do
--     one, two = lines[i]:match("([^,]+),([^,]+)")
--     print(one, two)
--     oneone, onetwo = one:match("([^,]+)-([^,]+)")
--     twoone, twotwo = two:match("([^,]+)-([^,]+)")
    
--     oneone = tonumber(oneone)
--     onetwo = tonumber(onetwo)
--     twoone = tonumber(twoone)
--     twotwo = tonumber(twotwo)

--     print(oneone, onetwo, twoone, twotwo)

--     if oneone >= twoone and onetwo <= twotwo then
--         print("one is in two")
--         result = result + 1
--     elseif oneone <= twoone and onetwo >= twotwo then
--         print("two is in one")
--         result = result + 1
--     end
-- end

-- Part 2
for i = 1, #lines do
    one, two = lines[i]:match("([^,]+),([^,]+)")
    print(one, two)
    oneone, onetwo = one:match("([^,]+)-([^,]+)")
    twoone, twotwo = two:match("([^,]+)-([^,]+)")
    
    oneone = tonumber(oneone)
    onetwo = tonumber(onetwo)
    twoone = tonumber(twoone)
    twotwo = tonumber(twotwo)

    print(oneone, onetwo, twoone, twotwo)

    range1 = math.max(oneone, twoone)
    range2 = math.min(onetwo, twotwo)

    if (range1 <= range2) then
        print("overlap")
        result = result + 1
    end
    -- Check if the ranges overlap
    
end

print(result)