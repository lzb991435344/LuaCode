local t = {[1]=1,[2]=10,[3]=2,[4]=25,[5]=3,[6]=50,[7]=4,[8]=15,[9]=5,[10]=15}

    local prisonList = {}
    local prison = {}
    local prisonId
    local punishTime
    for i = 1,#t do
        if i % 2 == 1 then
            prisonId = tonumber(t[i])
        elseif i % 2 == 0 then
            punishTime = tonumber(t[i])
        end
        if i % 2 == 0 then
            table.insert(prisonList, {prisonId = prisonId, punishTime = punishTime})
        end
        --i= i + 1
    end

    for k,v in pairs(prisonList) do
        if type(v) == "table" then
            for p,q in pairs(v) do
                print(p,q)
            end
        end
    end