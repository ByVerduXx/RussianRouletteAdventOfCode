sum = 0
for line in io.lines('input3.txt') do
    sub_line1 = string.sub(line, 1, string.len(line)/2)
    sub_line2 = string.sub(line, string.len(line)/2+1, string.len(line))
    for i = 1, #sub_line1 do
        found = false
        local c = string.sub(sub_line1, i, i) 
        for j = 1, #sub_line2 do
            local d = string.sub(sub_line2, j, j)
            if c == d then
                -- Transformamos a prioridad el caracter
                valor = string.byte(c)-96
                if valor < 0 then
                    valor = string.byte(c)-38
                end
                sum = sum + valor
                found = true
                break
            end
        end
        if found then
            break
        end
    end
end
print(sum)

sum = 0
lines = {}
for line in io.lines('input3.txt') do 
    lines[#lines + 1] = line
  end

for i = 1, #lines/3 do 
    --- Grupo de 3 elfos
    index = (i-1)*3
    --- Miramos los objetos que lleva cada elfo, el objeto que aparezca en las 3 es la badge
    for k = 1, #lines[index+1] do
        local c = string.sub(lines[index+1], k, k)
        if string.find(lines[index+2], c) and string.find(lines[index+3], c) then
            -- Transformamos a prioridad el caracter
            valor = string.byte(c)-96
            if valor < 0 then
                valor = string.byte(c)-38
            end
            sum = sum + valor
            break
        end
    end
end
print(sum)
