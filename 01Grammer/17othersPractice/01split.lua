
--根据split来划分字符串,将字符串放入表中
function mysplit(string, split)
    local list = {

    }

    local pos = 1
    if string.find("", split, 1) then
        error("split matches empty string!")
    end

    
    while true do
        local first, last = string.find(string, split, pos)
        print("first, last is:", first, last)
        print("pos:", pos)

        if first then
            table.insert(list, string.sub(string, pos, first - 1))
            
            pos = last + 1
            print("pos:", pos)
        else
            table.insert(list, string.sub(string, pos))
            break   
        end
    end

    return list
end



local string = "abcdefdeg" 
local split = "de"


local t = mysplit(string, split)

for key, value in pairs(t) do
    print(key, value)
end




