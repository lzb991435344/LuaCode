

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

function verTest(ver1, ver2)

	local flag = false 
	
	--第一个位
	local firstPos1 = string.find(ver1, "%.")
	local firstPos2 = string.find(ver2, "%.")


	local firstVersion1 = tonumber(string.sub(ver1, 1, firstPos1 - 1))
	local firstVersion2 = tonumber(string.sub(ver2, 1, firstPos1 - 1))
	 print(firstVersion1)


	if firstVersion1 > firstVersion2 then 
	--第二个位
	local secondStr1 = string.sub(ver1, firstPos1 + 1, string.len(ver1))
	local secondStr2 = string.sub(ver2, firstPos2 + 1, string.len(ver2))


	--print(secondStr1)
	local secondPos1 = string.find(secondStr1, "%.")
	local secondPos2 = string.find(secondStr2, "%.")

	local secondVersion1 = tonumber(string.sub(secondStr1, 1, secondPos1 - 1))
    local secondVersion2 = tonumber(string.sub(secondStr1, 1, secondPos1 - 1))
	 print(secondVersion1)


    --第三个位
    local thirdStr1 = string.sub(secondStr1, secondPos1 + 1, string.len(secondStr1))
    local thirdStr2 = string.sub(secondStr2, secondPos2 + 1, string.len(secondStr2))
    --print(thirdStr1)



    local thirdPos1 = string.find(thirdStr1, "%.")
    local thirdPos2 = string.find(thirdStr2, "%.")
    --print(thirdPos1)

    local thirdVersion1 = tonumber(string.sub(thirdStr1, 1, thirdPos1 - 1))
    local thirdVersion2 = tonumber(string.sub(thirdStr2, 1, thirdPos2 - 1))
    print(thirdVersion1)


    --第四位
    local fourVersion1 = tonumber(string.sub(thirdStr1, thirdPos1 + 1, string.len(thirdStr1)))
    local fourVersion2 = tonumber(string.sub(thirdStr2, thirdPos2 + 1, string.len(thirdStr2)))
    

    print(fourVersion1)    
end

local ver1 = "5.1.9.4"
local ver2 = "5.1.3.5"

--local res = compareVersion(ver1, ver2) 

--print(res)
verTest(ver1, ver2)





















