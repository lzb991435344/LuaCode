


local function randomSomeChoice(choiceList, needNum)
    local randRes = {}

    for i = 1, needNum  do
        local randVal = math.random(1, #choiceList)
        for k,v in pairs(choiceList) do
            if randVal == k then
                table.insert(randRes, v)
                break
            end
        end
    end

    return randRes
end


local randRes = randomSomeChoice({1,2,3,4,5}, 3)

for k,v in pairs(randRes) do
    print(k,v)
end


local position = {{594,595,},{1010,1011,},}
math.randomseed(tostring(os.time()):reverse():sub(1, 6))
print(position[1][1])
print(math.random(position[1][1],position[1][2]))
print(math.random(position[2][1],position[2][2]))