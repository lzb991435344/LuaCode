

local cfg = {
    govEvent ={
        {id = 1, next_id = {22, 33}},
        {id = 22, next_id = {66,77}},
        {id = 23,next_id ={56,78} }
    }
}


local function getNextAffairsId(currentAffairsId)
    local nextAffairsId = {}
    --local cfg = TcGovAffairs
    if cfg.govEvent ~= nil and next(cfg.govEvent) ~= nil then
        for k,v in ipairs(cfg.govEvent) do
            if v.id == currentAffairsId and v.next_id ~= nil then
                nextAffairsId = v.next_id
            end
        end
    end
    return nextAffairsId
end

local tmp = getNextAffairsId(1)

for k,v in pairs(tmp) do
     print(k, v)
end