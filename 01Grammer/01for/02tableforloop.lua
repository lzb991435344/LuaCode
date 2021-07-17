
local conf = {
    test = 1,
    dest = 9,
    user = {
        uid = 12,
        pfid = 14,
        coin = 888
    }
}

for k, v in pairs(conf) do

	if k == 'test' then 
		print("333")
	end	
	print(conf.user.uid)
    --print(k, v)
    --print(k, v)
    if type(v) == "table" then 
    	for p,q in pairs(v) do
    		print(p, q)
    	end	
    end	
end
--[[
--333
--12
--12
--12
--uid     12
--coin    888
--pfid    14
--
--
--]]

