

--[[
local str = "255.155.255.255"
local index = {}
local oid = {}


for k = 1,string.len(str) do
  if string.sub(str,k,k) == '.' then
    table.insert(index,k)
  end
end


table.insert(oid, string.sub(str, 1, index[1] - 1))
  for k=1,#index-1 do
    table.insert(oid,string.sub(str,index[k]+1,index[k+1]-1))
  end
table.insert(oid, string.sub(str,index[#index] + 1, string.len(str)))



for k,v in pairs(oid) do
	print(k, v)
end



]]

function getVersion(version)

	local index = {}
	local res = {}
	local len = string.len(version)
	for  i = 1, len  do
		if string.sub(version, i, i) == '.' then
			table.insert(index, i)
		end		
	end

	table.insert(res, string.sub(version, 1, index[1] - 1))
	for k = 1, #index - 1 do
		table.insert(res, string.sub(version, index[k] + 1, index[k + 1] - 1))
	end		

	table.insert(res, string.sub(version, index[#index] + 1, string.len(version)))

	return res
end	

function compareVersion(ver1, ver2)
	local ver1 = getVersion(ver1)
	local ver2 = getVersion(ver2)

	local res = true

	if #ver1 > #ver2 then 
		res = true
	elseif #ver1 < #ver2 then
		res = false
	else
	    for i = 1, #ver1 do
	    	if ver1[i] > ver2[i] then	 
	    		res = true
	    		break;
	    	elseif ver1[i] < ver2[i] then 
	    		res = false
	    		break;
	    	else
	    	   i = i + 1
	    	end	
	    end	
	end	
	return res
end

local ver1 = "5.1.3"
local ver2 = "5.1.4"

local res = compareVersion(ver1, ver2) 

print(res)



