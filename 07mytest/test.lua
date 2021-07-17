

local t = {1000,1001}
local t2 = {
    {1000, 1, 5}, 
    {1001, 2, 3},
    {1002, 3, 6}
}
local tmp = {}

for k, v in pairs(t2) do
	if t2[k][1] == t[k] then
		local index = t2[k][2]
		table.insert(tmp, index)
	end

end


for k, v in pairs(tmp) do
	print(k, v)
end
